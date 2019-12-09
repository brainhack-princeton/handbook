.. _registration:

===========================
Registration and resampling
===========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

No matter how you collect your data and the kind of analysis you’re planning, you will have to register your data along the way to a target space. The specific target and reference images will change, but the general principles for registration are the same now matter what you’re doing. We’re going to discuss some basic concepts and provide some scripts below.


A quick glossary
----------------

* **Grid:** how the data is sliced into separate voxels. It changes by resolution of your image and scanning FOV. (FOV = grid*voxel size).
* **Resolution:** the size of the voxels only. It is not the same thing as grid or space, because two images can be in different spaces but still be in 3 mm resolution. Likewise, two images can be in the same space (e.g., MNI) but one can be in 2 mm resolution and the other can be in 3 mm resolution.
* **Registration:** the transformation from one space to another
* **Resampling:** the transformation from one grid to another
* **Reference image:** the image that is in the desired space/grid  

Reslicing & resampling
----------------------

This how we take two images in the same space and make sure they have the same grid (meaning that they are the same resolution and have the same dimensions). To do this, there are various algorithms you can use:
Nearest neighbor: assign the voxel to the nearest voxel in the original space
Linear interpolation

Luckily, reslicing is easy with python! We have a script - resample.py - for this located in: :blue:`/jukebox/norman/pygers/handbook/sample_project/code/analysis`.

To run the code:

.. code-block:: bash

		$python resample.py $IMAGE_TO_RESAMPLE $REFERENCE_IMAGE

*If you want to use AFNI only, here’s some help from Meir:*
3dresample this AFNI command allows transformations between different mni spaces. It resamples the map in the second argument to the space of the map in the first argument, and outputs a map named third argument.

.. code-block:: bash

		3dresample -master /mnt/bucket/labs/hasson/meshulam/Utils/brain_templates/afni_2009c/icbm152_3mm.nii -inset /mnt/bucket/labs/hasson/meshulam/onlineL/spring18/processing/searchlight_masks/roi/harvardoxford-cortical_prob_SPL_thr10_bin.nii.gz -prefix /mnt/bucket/labs/hasson/meshulam/onlineL/spring18/processing/searchlight_masks/roi/harvardoxford-cortical_prob_SPL_thr10_bin_icbm152_3mm.nii.gz

Things to note:

* The code will save the image you want resampled in the same directory that the original image is in. It will have the same name as the original image with _resampled at the end.
* Make sure you provide the **full path to both images!**
* Change the interpolation type in the code if you don’t want nearest neighbor
* Check that the _resampled image has the exact same dimensions and is the same resolution as the reference image. (You can use fslinfo (FSL) or 3dinfo (AFNI) for this)

Registration
------------

This is the process of transforming one image from one space into the target space of the reference image. It can get complicated because of the various options:

* difference directions of transformations (e.g., which to assign as the reference image)
* different spaces to convert between (e.g., MNI vs. fsaverage)
* different software algorithms to register images (e.g., FSL, AFNI, ANTS, Freesurfer)

Because we’re focusing on fmriprep, we will first provide documentation with how to use the registration that is already computed by fmriprep. Once fmriprep is completed, all you need to do is know where to find the relevant outputs! All the work has been done for you… (Just kidding, it’s still difficult but at least registration is done.)

Volumetric space transformations
--------------------------------

For volumetric transformations, fmriprep uses a combination of Freesurfer, FSL, and ANTs to register images. However, your final transformation matrices will be saved in an ANTs transformation matrix. This is an .h5 file; it contains both the linear and nonlinear transforms. Let’s assume that you specified MNI space as your standard image for our examples.

1. **Original space: MNI → Target space: T1w**

* Example usage: you want to stay in subject-specific (e.g., MNI) space but you have an ROI in standard (e.g., MNI) space that you want to use
* Reference image: an image in T1w space 
* Input image: your ROI in MNI space
* Transformation: the .h5 file is located in your output from fmriprep in :blue:`/derivatives/fmriprep/sub-001/ses-01/anat/`

		* Example: ``sub-001_from-MNI152NLin2009cAsym_to-T1w_mode-image_xfm.h5``
		* For older fmriprep versions, “from/to” will be “space/target” 

* Command: `antsApplyTransforms <https://github.com/ANTsX/ANTs/issues/531>`_
		* -i = input image
		* -r = reference image
		* -t = transformation from fmriprep called by [transformFileName, useInverse]
		* -n = nearest neighbor interpolation

* Example command to transform the Glasser parcellation:
		
.. code-block:: bash

		antsApplyTransforms \
			-i HCP-MMP1_on_MNI152_ICMB2009a_nlin.nii.gz \
			-r fmriprep_BOLD_T1w_preproc_Tmean.nii.gz \
			-t [BIDS_DIR/derivatives/fmriprep/sub-001/ses-01/anat/sub-001_ses-01_T1w_from-MNI152NLin2009cAsym_to-T1w_warp.h5,0]  \
			-n NearestNeighbor -o Glasser_in_T1w.nii.gz
			-v 1

2. **Original space: MNI → Target space: EPI**

* Example usage: you have an ROI in MNI space and want to stay in your original epi space
* Reference image: an original EPI that has remained in this space (not any of the fmriprep outputs because those are automatically registered to T1w, MNI, or fsaverage space)
* Input image: your ROI in MNI space
* Transformations: this is really a two step transformation so you need two different matrices

		* MNI → T1w .h5 transformation as described above
		* T1w → EPI transformation: fmriprep saves this transformation in the :blue:`derivatives/work/fmriprep_wf` directory. Specifically, for subject 001 and task-story run 01, thie file would be located in :blue:`/func_preproc_ses_01_task_story_run_01_wf/bold_reg_wf/bbreg_wf/fsl2itk_fwd/affine.txt`
		* Go to the specific :blue:`func_preproc_ses_01_task_XX_run_XX` folder to get the matrix from whatever task/run you’re want to analyze

* Command: antsApplyTransforms - this time you will input both transformations
* Example command:

.. code-block:: bash

		antsApplyTransforms --default-value 0 --float 1 \
			--interpolation LanczosWindowedSinc -d 3 -e 3 --input {0} \
			--reference-image $EPI_ref_filename --output ROI_space-EPI.nii.gz \
			--transform $MNI_to_T1w.5 --transform affine.txt -v 

Surface space transformations
-----------------------------

1. **Original space: fsnative → Target space: T1w space (or any space outputted in fmriprep)**

* Example usage: you want to use aparc+aseg2009 in T1w space (NOTE: if you’re using the aparc+aseg atlas, it is already transformed to T1w space. You only need to do this if you want the updated aparc+aseg2009 version.) 
* Reference image: your outputted T1w images from fmriprep. This will be in the BOLD resolution in the space that you want (T1w, MNI, native). The newer versions of fmriprep also give you a specific reference image in your /ses-01/func/ directory; look for :blue:`space-T1w_boldref.nii.gz`. Just make sure that your reference image is 3D not 4D.
		* If you don’t have a reference image, you can make one by taking the mean across time using FSL’s `function fslmaths <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils>`_.
		* Command: ``fslmaths $EPI_4D_file -Tmean -mas $EPI_brain_mask EPI_3D_file.nii.gz``
* Input image: aparc+aseg or aparc+aseg2009 segmentatio
* Commands: To use Freesurfer, you will need to first convert your nifti files to .mgz. Then we will use the Freesurfer function label2vol to register from one space to another.
		* Convert .nii → .mgz: mri_convert EPI_3D_file.nii.gz EPI_3D_file.mgz
		* Register freesurfer segmentation to whatever space the EPi is in: 
 
 .. code-block:: bash

		mri_label2vol --seg $FREESURFER_DIR/aparc+aseg.mgz \
		--temp EPI_3D_file.mgz  \
		 --o $BOLD_DIR/aparc+aseg-in-BOLD.nii.gz --fillthresh 0.5 \
		--regheader $FREESURFER_DIR/aparc+aseg.mgz

* You can find an example script to do this in :blue:`/jukebox/norman/pygers/handbook/sample_project/code/preprocessing/aparc+aseg_registration.sh`










.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html

