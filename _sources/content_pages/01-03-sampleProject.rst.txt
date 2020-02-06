.. _sampleProject:

===========================================
Practice using BIDS with our sample dataset
===========================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

The goal of this sample project is for you to follow the instructions on the :ref:`converting data to BIDS<converting>`, :ref:`quality control with MRIQC<mriqc>`, and :ref:`preprocessing with fMRIprep<fmriprep>` pages to practice running all of the BIDS scripts located in :blue:`/jukebox/norman/pygers/handbook/new_study_template`. 

To do this, you will make a copy of the :blue:`new_study_template` directory and place it somewhere in your own directory, so that you can open and edit the scripts for yourself, following the instructions on the :ref:`converting data to BIDS<converting>` page. After running the BIDS apps included in the tutorial, you can compare your output with our sample output located in :blue:`/jukebox/norman/pygers/handbook/sample_project_output`.   

Sample dataset description
--------------------------
We have consent from a subject (sub-001) to scan him and share everything, including personally identifiable information. This is useful for learning because many available datasets have already removed personal information, which makes sense for obvious reasons. However, this isn’t always the best thing for learning how to preprocess datasets because the data shared is already in BIDS/NIfTI format, and/or already has the face removed. We’re giving you everything as if it has just come right from the scanner!

We’ve shared the dataset in its raw-est form (.dcm.gz files), as if you had just transferred the data from the scanner.

Here is the "fake" conquest location to simulate where it is located on the server after transferring the data from the scanner console: 

.. code-block:: bash

    /jukebox/norman/pygers/conquest/0219191_mystudy-0219-1114

*Tasks in the sample project*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We had sub-001 perform a couple of different tasks:

* **sound**: Sound check before scanning
* **story**: He listened to a story in the scanner. For more information on this specific story, see `Yeshurun et al 2017 <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5348256/>`_ describing the auditory stimulus.
* **faces**: He performed the face-matching task `Chai et al 2015 <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4474282/>`_.

How to use the sample project
-----------------------------
1. You should follow the step-by-step instructions on the :ref:`converting data to BIDS<converting>` page. The instructions on this page are meant to help you setup and use BIDS for your own study. But you can practice before you have collected your own data, by copying and using the sample data! In the step-by-step instructions, We've included some helpful notes and commands specific to the **sample project**. 

2. At any point in the process, you can compare your version of the :blue:`sample_project` to our sample output located in :blue:`/jukebox/norman/pygers/handbook/sample_project_output`. 

3. After you have successfully converted the raw dicom (.dcm) data to BIDS-formatted nifti files (.nii) and passed the bids-validator, you can submit jobs to run :ref:`quality control with MRIQC<mriqc>` and :ref:`preprocessing with fMRIprep<fmriprep>`. Once your jobs have started running, MRIQC will take ~20 minutes to run, and fMRIprep will take ~12 hours to run.

4. Congratulations on using BIDS to facilitate reproducible neuroimaging!   

