.. _templates:

=====================
Templates and atlases
=====================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

A quick glossary
----------------

* **Space:** the coordinate space in which templates/atlases live (independent of voxel dimensions!
* **Template:** the image that the data is actually going to be aligned to
* **Atlas:** labels applicable to a template in a space
* **Parcellations** divisions into parcels (usually into labeled sections)
		* Labels usually found in ‘.anot’ files
* **Registration:** transforming an image into the coordinate space of another. In the case of fMRI we register different brains into a common space. Bold data will be in the same resolution that you’re asking for no matter what.
* **fs:** freesurfer (surface space)
* **Resolution:** actual pixel dimensions of your data (3x3x3 etc.)
* **Asymmetric template:** actual hemispheres are not symmetric--otherwise people just mirror hemispheres!!
		* Talaraich space is symmetric (mirrored hemispheres)
* **Transformations:** taking a 4d brain image ( 3D voxels and time) and multiply it by a matrix (affine matrix for linear transformations) that tells you how to rotate and translate your brain image
* **Linear Transformations:** use a 4x4 affine matrix with the last dimension for time (timeseries) remains untouched. 
* **Nonlinear Transformations:** `ANTs <https://www.neuroinf.jp/fmanager/view/737/bah20150723-alex.pdf>`_ uses a previously `validated algorithm <https://www.ncbi.nlm.nih.gov/pubmed/19195496>`_ called Symmetric Normalization to register the brains


Templates
---------

Templates are typically anatomical brain images in a standard space (e.g., MNI space). Many templates are created by averaging anatomical images from a large sample of subjects (e.g., MNI152NLin2009cAsym). Templates are used as target images when spatially normalizing images in a subject-specific space to standard space (e.g., using ANTs). Templates may either be in volumetric or surface space.

Two very common volumetric templates are the MNI152NLin2009cAsym used by default in fMRIPrep and the MNI152NLin6Asym distributed by FSL. Volumetric templates are sometimes resampled to different spatial resolutions, such as 0.5 mm, 1.0 mm, and 2.0 mm isotropic voxels. The most common surface-based template is fsaverage. The spatial resolution of a surface template is determined by the linear divisions of an icosahedron (20-sided convex regular polygon; i.e., a d20 for the D&D folks) according to the following equation: if the number of linear divisions n = 64, you will end up with 20 * n**2 faces (81,920 faces/triangles, or 40,960 per hemisphere) and 2 + 10 * n**2 vertices per hemisphere (40,962). Common fsaverage resolutions are fsaverage (163,842 vertices per hemispheres), fsaverage6 (40,962 vertices per hemisphere), fsaverage5 (10,242 vertices per hemisphere).

Atlases
-------

* MNI atlas used by fmriprep: ICBM 152 Nonlinear atlases version 2009
		* `Download the Atlas here <http://www.bic.mni.mcgill.ca/ServicesAtlases/ICBM152NLin2009>`_
* Surface space
		* For each subject, you will get fsnative space (idiosyncratic number of vertices per hemisphere)
		* Standard spaces:
				* fsaverage(7) (163,842 vertices per hemisphere) 
				* fsaverage6 (40,962 vertices per hemisphere)
				* fsaverage5 (10,242 vertices per hemisphere)
				* The number of vertices is determined by the linear divisions of an icosahedron (20-sided polygon; i.e., a d20 for the D&D folks) according to the following equation: if the number of linear divisions n = 64, you will end up with 20 * n**2 faces (81,920 faces/triangles, or 40,960 per hemisphere) and 2 + 10 * n**2 vertices per hemisphere (40,962).

Atlases and parcellations
-------------------------

This is a type of Atlas where brain regions are clustered and labelled. Here is a list of useful parcellations if you want to select a specific ROI:

* Freesurfer atlases with the `lookuptable <https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/AnatomicalROI/FreeSurferColorLUT>`_
* Aparc+aseg: Desikan-Killiany atlas
* Aparc+a2009+aseg: Destrieux atlas
* `Yeo <https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/AnatomicalROI/FreeSurferColorLUT>`_: in surface or MNI
* `Schaefer 2018 <https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/brain_parcellation/Schaefer2018_LocalGlobal>`_ - in surface, MNI, HCP - new Yeo
* `Glasser <https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/brain_parcellation/Schaefer2018_LocalGlobal>`_
* `Powers 2011 <https://www.jonathanpower.net/2011-neuron-bigbrain.html>`_

References
----------

Desikan, R. S., Ségonne, F., Fischl, B., Quinn, B. T., Dickerson, B. C., Blacker, D., Buckner, R. L., Dale, A. M., Maguire, R. P., Hyman, B. T., Albert, M. S., & Killiany, R. J. (2006). An automated labeling system for subdividing the human cerebral cortex on MRI scans into gyral based regions of interest. NeuroImage, 31(3), 968–980. https://doi.org/10.1016/j.neuroimage.2006.01.021

Destrieux, C., Fischl, B., Dale, A., & Halgren, E. (2010). Automatic parcellation of human cortical gyri and sulci using standard anatomical nomenclature. NeuroImage, 53(1), 1–15. https://doi.org/10.1016/j.neuroimage.2010.06.010

Glasser, M. F., Coalson, T. S., Robinson, E. C., Hacker, C. D., Harwell, J., Yacoub, E., Ugurbil, K., Andersson, J., Beckmann, C. F., Jenkinson, M., Smith, S. M., & Van Essen, D. C. (2016). A multi-modal parcellation of human cerebral cortex. Nature, 536(7615), 171–178. https://doi.org/10.1038/nature18933

Tzourio-Mazoyer, N., Landeau, B., Papathanassiou, D., Crivello, F., Etard, O., Delcroix, N., Mazoyer, B., Joliot, M. (2002). Automated anatomical labeling of activations in SPM using a macroscopic anatomical parcellation of the MNI MRI single-subject brain. NeuroImage, 15(1), 273–289. https://doi.org/10.1006/nimg.2001.0978

Yeo, B. T. T., Krienen, F. M., Sepulcre, J., Sabuncu, M. R., Lashkari, D., Hollinshead, M., Roffman, J. L., Smoller, J. W., Zöllei, L., Polimeni, J. R., Fischl, B., Liu, H., & Buckner, R. L. (2011). The organization of the human cerebral cortex estimated by intrinsic functional connectivity. Journal of Neurophysiology, 106(3), 1125–1165. https://doi.org/10.1152/jn.00338.2011


.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-07-overview.html
