.. _fmriprep:

===========================
Preprocessing with fMRIprep
===========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Once you’ve converted your fMRI data to BIDS, you can begin preprocessing the data using fMRIPrep (`Esteban et al 2019 <https://doi.org/10.1101/306951>`_). FMRIprep is a BIDS App—a tool specifically designed to capitalize on the standardized format and rich metadata of BIDS. 

Each version of fMRIPrep is released as a `Docker <https://www.docker.com/>`_ container (an encapsulated software environment containing all dependencies). For most purposes, we recommend running fMRIPrep on your institution's server (instead of locally). To run fMRIPrep on a server without administrative privileges, we use `Singularity <https://www.sylabs.io/docs/>`_ (`Kurtzer et al 2017 <https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0177459>`_) instead of Docker. Singularity must be installed on the server to build and run Singularity images such as fMRIPrep. The fMRIPrep Docker image can be converted to a Singularity image for use on the server by running Singularity’s build command on Poldrack Lab’s fMRIPrep Docker image on Docker Hub:

.. code-block:: bash

  $ singularity build fmriprep-v20.2.0.simg docker://poldracklab/fmriprep:20.2.0

NOTE: At Princeton, Singularity images have been made for us! The sample scripts use Singularity images that already exist, so you do NOT need to build your own fMRIPrep Singularity image. 

Running fMRIPrep on a single subject may take several hours. To run the fMRIPrep on the server, we recommend using your institution’s job scheduler (at Princeton, we use `Slurm <https://slurm.schedmd.com/>`_). 

Running fMRIPrep
================
The ``slurm_fmriprep.sh`` script (which you can find in the :blue:`code/preprocessing/` directory) will run fMRIPrep on the cluster using the Slurm scheduler. It first runs fMRIprep for an individual subject, and then defaces the preprocessed "template" T1w image that is output by fMRIPrep. 

This script will use the following two scripts:

* ``run_fmriprep.sh`` (this runs fMRIPrep)
* ``deface_template.sh`` (this defaces the template T1w) 

*Before running for the first time*
-----------------------------------
* Customize your fMRIprep command line argument by understanding all the different options in the `fMRIPrep documentation <https://fmriprep.readthedocs.io/en/stable/usage.html>`_!

* Open ``slurm_fmriprep.sh`` and update the array number to list the subjects you want to run through fMRIPrep. You can run multiple subjects in parallel by using arrays (e.g., #SBATCH --array=001,002,003,004).

* Update the #SBATCH --mail-user line to include your email address if you want to get email alerts when the job begins, ends, or fails.

.. TIP::
    Remember, in Slurm scripts, lines that start with ``#SBATCH`` are Slurm commands, not comments! All other lines that start with ``#`` are regular comments. 

*Submit your fMRIPrep job*
--------------------------

* Make sure you are in the directory where the slurm script lives (:blue:`code/preprocessing/`). Then use sbatch command to submit the job.

.. code-block:: bash

  # make sure you are in the code/preprocessing directory
  cd /jukebox/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing/

  # submit the job
  sbatch slurm_fmriprep.sh

fMRIPrep Report
================
fMRIPrep outputs will live in :blue:`/data/bids/derivatives/fmriprep/`

To have a quick look at the output of fMIRprep and make sure it ran without issues, check the *.html* output file for that subject. The *.html* file begins with a brief summary, including info about which structural images and resampling targets were used, and which functional runs were analyzed. For functional runs, make sure that slice-timing correction and susceptibility distortion correction were applied if that is what you wanted to happen! 

Here are some general things to look for:

* The images are dynamic and portray before/afters. 
* Summary of the flags used in the actual fMRIprep analysis and all the collected confounds are summarized for each run.
* You can get a quick sense of the quality of the signal by looking at the `carpetplots <https://www.sciencedirect.com/science/article/pii/S1053811916303871?via%3Dihub>`_ and see the effect of motion (FD) and fluctuations of the global signal in whole-brain (brain mask), CSF and white matter over the time-course. 
* The section on the correlations among nuisance regressors can guide the decisions on removing confounds.
* Any errors that may have occurred during preprocessing will be listed at the end of the .html report. 

For more details on fMRIPrep outputs, check `fMRIPrep docs <https://fmriprep.readthedocs.io/en/stable/outputs.html#visual-reports>`_ or our `Understanding your fMRIPrep outputs <./03-05-fmriprepOutputs.html>`_ page. 

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html
