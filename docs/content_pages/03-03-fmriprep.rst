.. _fmriprep:

===========================
Preprocessing with fMRIprep
===========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Once you’ve converted your fMRI data to BIDS, you can begin preprocessing the data using fMRIPrep (`Esteban et al 2019 <https://doi.org/10.1101/306951>`_). FMRIprep is a BIDS App—a tool specifically designed to capitalize on the standardized format and rich metadata of BIDS. Each version of fMRIPrep is released as a `Docker <https://www.docker.com/>`_ container (an encapsulated software environment containing all dependencies). For use on a fMRIPrep is packaged as a Docker container. For most purposes, we recommend running fMRIPrep on your institutions server (instead of locally). To run fMRIPrep on server without administrative privileges, we use `Singularity <https://www.sylabs.io/docs/>`_ (`Kurtzer et al 2017 <https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0177459>`_) instead of Docker. Singularity must be installed on the server to build and run Singularity images such as fMRIPrep. The fMRIPrep Docker image can be converted to a Singularity image for use on the server by running Singularity’s build command on Poldrack Lab’s fMRIPrep Docker image on Docker Hub:

* Building the Singularity image:
	* singularity build fmriprep.sqsh docker://poldracklab/fmriprep

Running fMRIPrep on a single subject may take several hours. To run the fMRIPrep on the server, we recommend using your institution’s job scheduler—in our case `Slurm <https://slurm.schedmd.com/>`_. Alternatively, you can create a persistent interactive session using, e.g., `tmux <https://github.com/tmux/tmux>`_ or screen to ensure that the fMRIPrep keeps running even if you lose your network connection.

Preprocessing (fMRIPrep)
------------------------

Now that you have used heudiconv to get your data as nifti’s into the BIDS format and indicated which functional runs have to be corrected with which fieldmaps, you should run fMRIPrep to preprocess these data. You can do this by running the script (:blue:`slurm_fmriprep.sh`) that needs to script run_fmriprep.sh (both in :blue:`new_study_template/code/preprocessing/`).

This script will run fmriprep for an individual subject using slurm. 

*Before running for the first time:*

* Make sure your paths are correct in globals.sh. If you need to, run one line at a time in slurm_fmriprep.sh to make sure the paths are correct.
* Find more on how to customize your fMIRprep command line argument here.
* If planning to run using a job scheduler (slurm in particular), open slurm_fmriprep.sh and update the array number to be your subject number (you can run multiple subjects at the same time by using arrays).
* Update to include your email address if you want to get email alerts when the code is running/completed.

*Submit job from code directory:*

.. code-block:: bash

	# Example code: 
	cd /jukebox/norman/pygers/handbook/sample_project/code/preprocessing/
	sbatch slurm_fmriprep.sh

Quality checks (MRIQC)
----------------------

To get an idea of the quality of your fMRI data, you can use the MRI Quality Check (MRIQC) which is the script slurm_mriqc.sh (which you can find in :blue:`/jukebox/norman/pygers/handbook/code/`). This script will need :blue:`run_mriqc.sh` and :blue:`run_mriqc_group.sh`. This script will run mriqc (quality metrics) for an individual subject followed by the group summary statistics using slurm. 

*Before running for the first time:*

* Open :blue:`slurm_mriqc.sh` and update the array number to be your subject number (you can run multiple subjects at the same time by using arrays). 
* Update to include your email address if you want to get email alerts when the code is running/completed.

*Submit job from code directory:* 

.. code-block:: bash

		cd /jukebox/norman/pygers/handbook/sample_project/code/preprocessing/

Checking the output of fMRIprep and MRIQC
-----------------------------------------

FMRIprep will output your data in the :blue:`/derivatives` directory of your folder. After fmriprep successfully runs, this is what your bids :blue:`directory/derivatives/` will look like (adapted from BIDSification):

.. code-block:: bash

   $ tree

   └── new_study_template
       └── data 
           └── bids
               └── sub-001
               └── sub-002
               └── etc.
               └── derivatives          # this is where all your BIDS derivatives will be

                   └── mriqc            # mriqc output will go here
                       └── logs         # slurm logs will go here
                   └── fmriprep         # fmriprep-preprocessed data will go here
                       └── logs         # slurm logs will go here
                   	   └── sub-001		# all data from sub-001 will go here
                   	       └── anat 	# all anatomical preprocessing
                   	       └── func 	# all functional preprocessing in all output spaces
                   	   └── sub-001.html	# summary of all of sub-001 preprocessing
                   └── freesurfer 		# if you ran freesurfer, the output data will go here (covered more in detail in the registration section)
                   └── work				# all intermediate outputs from fmriprep

**fMRIprep html:**

To have a quick look at the output of fMIRprep and make sure the analysis went through without issues check the html outputs (saved in “fmriprep” folder along with subject folders)
File begins with a brief summary, including info such as what structural images and resampling targets were used in the analysis and which functional runs were analyzed.

Some general points about the html file (for more details check `here <https://fmriprep.readthedocs.io/en/stable/outputs.html#confounds>`_):

* The images are dynamic and portray before/afters. 
* Summary of the flags used in the actual fMRIprep analysis and all the collected confounds are summarized for each run.
* You can get a quick sense of the quality of the signal by looking at the `carpetplots <https://www.sciencedirect.com/science/article/pii/S1053811916303871?via%3Dihub>`_ and see the effect of motion (FD) and fluctuations of the global signal in whole-brain (brain mask), CSF and white matter over the time-course. 
* The section on the correlations among nuisance regressors can guide the decisions on removing confounds.

MRIQC
-----

MRIQC outputs an MRIQC group bold report and separate MRIQC reports for each subject/session. To have a quick look at the quality of the data acquired for your subjects, a good first start is to look at the group bold report to see if the `image quality metrics <https://mriqc.readthedocs.io/en/stable/measures.html>`_ shows any outlier subjects/sessions with respect to the quality of the data. When this is the case, you should check the subject/session-specific MRIQC to see if you can figure out what went wrong. It is recommended that you always check the framewise displacement and temporal SNR. 


.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html
