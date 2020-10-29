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
    $ ls -a
    $ cd .heudiconv/001/ses-01/info
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

    # activate local conda environment (see week 4 preparation)
    $ conda activate pygers
    $ conda list #check that fsleyes package is installed
    # if fsleyes package is NOT installed:
    $ conda install -c conda-forge fsleyes

    # open original T1w and defaced T1w in FSLeyes
    $ cd /Volumes/LAB/YOURDIRECTORY/pygers_workshop/sample_study/data/bids
    $ fsleyes derivatives/deface/sub-001_ses-01_T1w_defaced.nii.gz sub-001/ses-01/anat/sub-001_ses-01_T1w.nii.gz &

    # open a functional time-series
    $ fsleyes sub-001/ses-01/func/sub-001_ses-01_task-story_run-01_bold.nii.gz &

Using the BIDS validator
------------------------

You can always use the `browser version <https://bids-standard.github.io/bids-validator/>`_ of the BIDS validator. However, if you have a large dataset to validate, this could take awhile. 

We are going to use our own installation of the BIDS validator on the server. Go back to your *scotty* Terminal: 

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

First we will fill in fields with "TODO" in the following three files: 

* :blue:`/data/bids/task-faces_bold.json`

* :blue:`/data/bids/task-sound_bold.json`

* :blue:`/data/bids/task-story_bold.json`

`Cognitive Atlas <https://www.cognitiveatlas.org/tasks/a/>`_ to lookup tasks for `CogAtlasID` field. 

**This is where we ended week 4! The remaining content on this page will be covered in week 5.** 

To be continued (week 5)...
***************************

Next, open and edit :blue:`/code/preprocessing/step2_preproc.sh`. This script will delete scout and _dup scans, as well as add the `IntendedFor` field to the fieldmap `.json` files. Since we did not collect fieldmap scans for our sample dataset, we don't need the `IntendedFor` field and will comment out lines 20-66. Don't forget to git commit your changes to :blue:`step2_preproc.sh`! 

.. code-block:: bash

    $ cd code/preprocessing/
    $ git status
    $ git add step2_preproc.sh
    $ git commit -m "ignore IntendedFor addition to fieldmap json"

    # run the script with (1) input argument: subjectID
    $ ./step2_preproc.sh 001
    $ tree #no more scouts or dups!

    # run bids-validator again
    $ pygers
    $ bids-validator sample_study/data/bids/

Preparing to run MRIQC and fMRIPrep
-----------------------------------

The first thing we need to do is setup your :blue:`/scratch` directory to store MRIQC and fMRIPrep work files. At PNI, we are supposed to use :blue:`/scratch` to store intermediate files that are generated during analysis (or just temporary files in general). :blue:`/scratch` is not backed up!

.. code-block:: bash

    $ cd /jukebox/scratch
    # if you have not already created a directory for yourself on scratch: 
    $ mkdir <name>
    $ cd <name> #move into your scratch directory
    $ mkdir work/pygers #this is where we will send our pygers sample dataset work files

If you are not at PNI, then the modification you will need to make is to setup a work directory *outside* of your BIDS directory. Note, that this is different than the directory structure copied from our :blue:`/new_study_template`. 

.. code-block:: bash

    $ pygers
    $ cd sample_study/data
    $ mkdir work 
    $ cd bids/derivatives
    $ rm -r work #remove old work directory

Open the following scripts in your text editor and make the following edits: 

* :blue:`globals.sh`: Add the path to your scratch work directory.

.. code-block:: bash

    scratch_dir=/jukebox/scratch/YOURDIRECTORY/work/pygers
    # if you are not at PNI, this will be the path to sample_study/data/work

For the next four scripts, there are some substantial modifications we need to make in order to use the newest versions of MRIQC and fMRIPrep. Instead of listing each individual change, I have copied each script below. You should modify your copy of each of these scripts to match. 

* :blue:`deface_template.sh`

.. code-block:: bash

    #! /bin/bash

    # LOAD GLOBAL VARIABLES AND MODULES ON THE CLUSTER
    source globals.sh   
    module load fsl/6.0.2
    module load pydeface/2.0.0

    sid=$1

    subj_dir=sub-$sid

    T1=$bids_dir/derivatives/fmriprep/$subj_dir/ses-01/anat/${subj_dir}_ses-01_desc-preproc_T1w.nii.gz
    pydeface $T1

    T1_defaced=$bids_dir/derivatives/fmriprep/$subj_dir/ses-01/anat/${subj_dir}_ses-01_desc-preproc_T1w_defaced.nii.gz
    mv $T1_defaced $defaced_dir

* :blue:`run_mriqc.sh`

.. code-block:: bash

    #!/bin/bash

    source globals.sh

    singularity run --cleanenv \
        --bind $bids_dir:/bids \
        --bind $scratch_dir:/scratch \
        --bind /usr/people \
        /jukebox/hasson/singularity/mriqc/mriqc-v0.15.1.simg \
        --participant-label $1 \
        --correct-slice-timing --no-sub \
        --nprocs 8 -w /scratch \
        /bids /bids/derivatives/mriqc participant

* :blue:`run_mriqc_group.sh`

.. code-block:: bash

    #!/bin/bash

    source globals.sh

    singularity run --cleanenv \
        --bind $bids_dir:/bids \
        --bind $scratch_dir:/scratch \
        --bind /usr/people \
        /jukebox/hasson/singularity/mriqc/mriqc-v0.15.1.simg \
        --correct-slice-timing --modalities T1w bold \
        --no-sub \
        --nprocs 8 -w /scratch \
        /bids /bids/derivatives/mriqc group

* :blue:`run_fmriprep.sh` 

.. code-block:: bash

    #!/bin/bash

    source globals.sh

    export SINGULARITYENV_TEMPLATEFLOW_HOME=/home/fmriprep/.cache/templateflow

    singularity run --cleanenv \
        --bind $project_dir:/project \
        --bind $scratch_dir:/scratch \
        --bind /usr/people \
        --bind /jukebox/hasson/templateflow:/home/fmriprep/.cache/templateflow \
        /jukebox/hasson/singularity/fmriprep/fmriprep-v20.2.0.simg \
        --participant-label sub-$1 \
        --fs-license-file /project/code/preprocessing/license.txt \
        --no-submm-recon \
        --use-syn-sdc --bold2t1w-dof 6 \
        --nthreads 8 --omp-nthreads 8 \
        --output-spaces T1w fsaverage:den-41k \
                        MNI152NLin2009cAsym:res-native MNI152NLin2009cAsym:res-2 \
        --write-graph --work-dir /scratch \
        /project/data/bids /project/data/bids/derivatives participant

Commit your changes! 

.. code-block:: bash

    $ cd code/preprocessing/
    $ git status
    $ git add globals.sh
    $ git commit -m "add scratch_dir"
    $ git add deface_template.sh
    $ git commit -m "update fmriprep anat directory"
    $ git add run_mriqc.sh
    $ git add run_mriqc_group.sh
    $ git commit -m "update MRIQC version; send work to scratch"
    $ git add run_fmriprep.sh
    $ git commit -m "update fmriprep version; add fieldmapless SDC; send work to scratch"
    $ git push

Using SLURM to submit jobs
--------------------------

Open the following scripts in your text editor and make the following edits:  

* :blue:`slurm_mriqc.sh`: (Line 25) add your email address.

* :blue:`slurm_fmriprep.sh`: (Line 12) reduce requested time to 18:00:00; (Line 25) add your email address.

Commit your changes! 

.. code-block:: bash

    $ git status
    $ git add slurm_mriqc.sh
    $ git add slurm_fmriprep.sh
    $ git commit -m "update email address and requested time"
    $ git push

    # submit SLURM jobs!
    $ pwd #make sure you are in the /code/preprocessing directory
    $ sbatch slurm_mriqc.sh
    $ sbatch slurm_fmriprep.sh
    $ squeue -u <netID>

Helpful SLURM commands: 

.. code-block:: bash

    $ sbatch <script.sh>        #submit a job
    $ squeue                    #list all jobs running
    $ squeue -u <netID>         #list your jobs
    $ scancel <jobID>           #cancel a job
    $ scancel -u <netID>        #cancel all your jobs
    $ scontrol hold <jobID>     #hold a job from being scheduled
    $ scontrol release <jobID>  #release a job to be scheduled

`Return to workshop info <./syllabus2020.html>`_

