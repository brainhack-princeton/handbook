:orphan:

==========================================
Pygers Workshop Notes - Week 4 (Fall 2020)
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue


Exploring the outputs of HeuDiConv
----------------------------------

.. code-block:: bash

    # check the status of step1_preproc.sh in your tmux session
    $ tmux ls #list available tmux windows
    $ tmux a -t heudiconv #attach to heudiconv tmux window
    # ctrl + b, d to detach from tmux window

    # explore data/dicom
    $ pygers #cd to pygers directory
    $ cd sample_study/data/dicom
    $ ls
    $ ls check_volumes/
    $ cat check_volumes/001_01_index.csv
    $ ls 0219191_mystudy-0219-1114/dcm/ #unzipped dicoms!

    # explore data/bids
    $ cd ../bids/
    $ tree
    $ ls .*
    $ cd ./heudiconv/001/ses-01/info
    $ ls

    # look at a nifti header
    $ module load fsl
    $ cd sub-001/ses-01/func/
    $ fslhd sub-001_ses-01_task-story_run-01_bold.nii.gz
    $ fslinfo sub-001_ses-01_task-story_run-01_bold.nii.gz

Looking at Sam's brain!
-----------------------

Make sure you have mounted a server volume (via Finder) so that you can access files on the server from a *local* Terminal. 

Now open a *local* Terminal and work from there: 

.. code-block:: bash

    # activate local conda environment
    $ conda activate pygers
    $ conda list #check that fsleyes package is installed
    # if fsleyes package is NOT installed:
    $ conda install -c conda-forge fsleyes

    # open original T1w and defaced T1w in FSLeyes
    $ cd /Volumes/LAB/YOURDIRECTORY/pygers_workshop/sample_study/data/bids
    $ fsleyes sub-001/ses-01/anat/sub-001_ses-01_T1w.nii.gz derivatives/deface/sub-001_ses-01_T1w_defaced.nii.gz &

    # open a functional time-series
    $ fsleyes sub-001/ses-01/func/sub-001_ses-01_task-story_run-01_bold.nii.gz &

Using the BIDS validator
------------------------

`Browser version <https://bids-standard.github.io/bids-validator/>`_

We are going to use our own installation of the BIDS validator. Go back to your server Terminal: 

.. code-block:: bash

    $ conda activate pygers
    $ node -v #check your version of node
    $ conda install -c conda-forge nodejs=11 #install a newer version of node
    $ node -v #check new version (11.14.0)
    $ npm install -g bids-validator
    $ which bids-validator
    $ bids-validator -v #1.5.7

    # run bids-validator; input is a bids directory
    $ pygers
    $ bids-validator sample_study/data/bids/

Examine the ERRORS (red) and WARNINGS (yellow). Errors need to be fixed before proceeding! Warnings should be fixed before publishing. 

`Cognitive Atlas <https://www.cognitiveatlas.org/tasks/a/>`_

Open and edit :blue:`/code/preprocessing/step2_preproc.sh`. Since we did not collect fieldmap scans for our sample dataset, we will comment out lines 20-66. 

:blue:`step2_preproc.sh` has 1 input: subjectID

.. code-block:: bash

    $ cd code/preprocessing/
    $ ./step2_preproc.sh 001
    $ tree #no more scouts or dups!

    # run bids-validator again
    $ pygers
    $ bids-validator sample_study/data/bids/

Using SLURM to submit jobs
--------------------------

Open the following scripts in your text editor and make the following edits:  

* :blue:`slurm_mriqc.sh`: Update line 25 with your email address.

* :blue:`slurm_fmriprep.sh`: Update line 25 with your email address.

* :blue:`run_mriqc.sh`: Update version in line 7 to `mriqc-v0.15.1.simg` 

* :blue:`run_mriqc_group.sh`: Update version in line 7 to `mriqc-v0.15.1.simg`

* :blue:`run_fmriprep.sh`: Update version in line 7 to `fmriprep-v20.2.0.simg`. Add `--use-syn-sdc` to the command. 

.. code-block:: bash

    # commit and push to GitHub
    $ cd code/preprocessing/
    $ git status
    $ git add slurm_mriqc.sh
    $ git add slurm_fmriprep.sh
    $ git commit -m "update email address"
    $ git add run_mriqc.sh
    $ git add run_mriqc_group.sh
    $ git commit -m "update MRIQC version"
    $ git add run_fmriprep.sh
    $ git commit -m "update fmriprep version; use fieldmap-less SDC"
    $ git push

    # submit SLURM jobs!
    $ pwd #make sure you are in preprocessing directory
    $ sbatch slurm_mriqc.sh
    $ sbatch slurm_fmriprep.sh
    $ squeue -u <netID>

Helpful SLURM commands: 

.. code-block:: bash

    $ sbatch            #submit a job
    $ squeue            #list all jobs running
    $ squeue -u <netID> #list your jobs
    $ scancel <jobID>   #cancel a job

`Return to workshop info <./syllabus2020.html>`_

