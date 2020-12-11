.. _sampleProjectWithBIDS:

========================================
Practice using BIDS with our sample data
========================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

The goal of these `sample data <https://zenodo.org/record/3677090>`_ is to provide a worked example for :ref:`converting data to BIDS<converting>`, running :ref:`quality control with MRIQC<mriqc>`, and :ref:`preprocessing with fMRIprep<fmriprep>`. This will allow you to practice running our helper scripts---located at the `handbook-code <https://github.com/brainhack-princeton/handbook-code>`_ repository on GitHub. We also provide sample derivatives so you can check your results.

Sample data description
-----------------------
This public dataset was acquired (with informed consent) specifically for use with this handbook :cite:`samuel_a_nastase_2020_3677090`. The data were acquired using the `ReproIn <https://github.com/ReproNim/reproin>`_ naming convention on a Siemens Skyra 3T MRI scanner. Many public fMRI datasets contain anonymized NIfTI images and have already been converted to BIDS format, making it difficult to learn best practices in data acquisition and standardization in a hands-on fashion. This dataset, on the other hand, contains raw, non-anonymized DICOM images intended to mimic data directly from the scanner. The dataset includes four functional runs with the `"Pretty Mouth and Green My Eyes" <https://openneuro.org/crn/datasets/ds002345/files/stimuli:prettymouth_audio.wav>`_ naturalistic spoken story stimulus (available as part of the `Narratives <https://openneuro.org/datasets/ds002345>`_ data collection) :cite:`yeshurun2017same` :cite:`nastase2019database`, one functional run with a block-design emotional faces task :cite:`chai2015functional`, a T1-weighted anatomical image, and auxiliary scans (e.g., scout, soundcheck). The brain data are contributed by author S.A.N. and are authorized for non-anonymized distribution.

The tasks are labeled as follows:

* **sound**: Auxiliary soundcheck scans can be ignored.
* **story**: Subject passively listened to the naturalistic spoken story stimulus "Pretty Mouth and Green My Eyes" by J. D. Salinger.
* **faces**: Subject performed an emotional face-matching task.

Getting the sample data
-----------------------

You can download the sample data using the an internet browser by navigating to the `Zenodo repository <https://zenodo.org/record/3677090>`_ and clicking `Download`. Alternatively, you could download the dataset from a Linux/MacOS command line using the following command:

.. code-block:: bash

    wget https://zenodo.org/record/3677090/files/0219191_mystudy-0219-1114.tar.gz

You can unzip and extract files from the tarball (tar archive) using the following command:

.. code-block:: bash

    tar -xvzf 0219191_mystudy-0219-1114.tar.gz 

You can use a similar procedure to get the sample derivatives:

.. code-block:: bash

    wget TODO!!!
    tar -xvzf TODO!!!

If you're at Princeton and have access to the PNI server, you can use a preexisting version of sample data and derivatives. The sample data are organized to mimic the `conquest` location where data are stored after transferring data from the scanner console. The sample data are available at :blue:`/jukebox/norman/pygers/conquest/0219191_mystudy-0219-1114`. The sample derivatives are available at :blue:`/jukebox/norman/pygers/handbook/sample_project_output_v1.4.0`.

How to use the sample data and derivatives
------------------------------------------

1. Follow the step-by-step instructions on :ref:`converting data to BIDS<converting>`! The instructions on this page are intended to help you set up and use BIDS for your own study---but you can practice using the sample data! In the step-by-step instructions, we've included notes and commands specific to the sample dataset.

2. At any point in the process, you can compare your progress on the sample data to the sample derivatives. 

3. After you have successfully converted the raw DICOM (.dcm) files to BIDS-formatted NIfTI (.nii) files and successfully run the BIDS-Validator, you can begin running :ref:`quality control with MRIQC<mriqc>` and :ref:`preprocessing with fMRIprep<fmriprep>`. Note, however, that MRIQC will take ~20 minutes to run on the sample data, and fMRIPrep may take up to ~12 hours to run!

Resources
^^^^^^^^^

* `Princeton Handbook for Reproducible Neuroimaging: Sample Data <https://doi.org/10.5281/zenodo.3677090>`_

* `Princeton Handbook for Reproducible Neuroimaging: Code <https://github.com/brainhack-princeton/handbook-code>`_

References
^^^^^^^^^^

.. bibliography:: ../refs.bib
  :style: apa
  :filter: docname in docnames

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html


