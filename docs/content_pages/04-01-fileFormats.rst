.. _fileFormats:

=============================
Input/output and file formats
=============================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Load data into python
---------------------

* Import `nibabel <https://pypi.org/project/nibabel/>`_ as nib (into a jupyter notebook)
* Import NiftiMasker and MultiNiftiMasker of `nilearn <https://nilearn.github.io/user_guide.html>`_: :blue:`from nilearn.input_data import` `NiftiMasker <https://nilearn.github.io/modules/reference.html#module-nilearn.input_data>`_ :blue:`,` `MultiNiftiMasker <https://nilearn.github.io/modules/reference.html#module-nilearn.input_data>`_

Load your mask of your region-of-interest as well as your epi-data into the jupyter notebook in order to get the voxels extracted of your region-of-interest for each of your epi-images.

.. code-block:: bash

		def load_epi_data(sub, ses, task):
		  # Load MRI file
		  epi_in = os.path.join(data_dir, sub, ses, 'func', "%s_%s_task-%s_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz" % (sub, ses, task))
		  epi_data = nib.load(epi_in)
		  print("Loading data from %s" % (epi_in))
		  return epi_data

		def load_mniroi_mask(ROI_name):
		  mnimaskdir = os.path.join(mnirois_dir)
		  # load the mask
		  maskfile = os.path.join(mnimaskdir, "%s.nii" % (ROI_name))
		  mask = nib.load(maskfile)
		  print("Loaded %s mask" % (ROI_name))
		  return mask

If you want to open the actual image then add get_data() or get_fdata(), e.g.:

.. code-block:: bash

		mask.get_data()

To then extract the voxels of your mask from your loaded epi-data:

.. code-block:: bash

		nifti_masker = NiftiMasker(mask_img=mask)
		maskedData = nifti_masker.fit_transform(epi_data)

If you want to high pass filter and clean data from confounds (e.g. motion, white matter, csf, etc.). The confounds_file is the file with the confounds you want to use that you can select from the many confounds that fmriprep outputs. 

.. code-block:: bash

		nifti_masker = NiftiMasker(mask_img=mask,  high_pass=1/128, t_r=1.5)
		maskedData = nifti_masker.fit_transform(epi_data, confounds=confound_file)



.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-07-overview.html
