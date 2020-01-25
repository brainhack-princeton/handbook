.. _converting:

=======================================
Converting to BIDS using HeuDiConv 
=======================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Benefits of using BIDS format
=============================

BIDS is a standard and widely-used format of structuring data. It facilities:

* **Using and re-using data:** by arranging data in a standard way, using datasets collaboratively within and across labs will be facilitated (no need to rearrange data). It also facilitates future usages of the same datasets (easier to figure out old codes).
* **Data analysis:** There are several software packages that accept only BIDS format as input -- such as fMRIprep and MRIQC. And the number of these BIDS apps are growing. 
* **Sharing data:** Data sharing is an important element of reproducible science and a standard data sharing formatting is required for this purpose. Currently OpenNeuro accepts datasets in BIDS format. Some grants require public data sharing and using BIDS from the beginning of data collection can save time and energy at the time of sharing. 
* **Checking data integrity:** By validating your data structure through bids-validator, potential problems or errors in the data can be discovered.

`Find out more about BIDS data specifications here <https://bids-specification.readthedocs.io/en/stable/>`_.

Do this once: Setting up your directory structure for a new study
=================================================================

Getting data off the scanner in a BIDS-formatted way requires that your directories are setup in a specific way. To make things simpler, we have made a template folder with the directory structure already in place. Copy the folder :blue:`new_study_template`, which can be found in :blue:`/jukebox/norman/pygers/handbook/new_study_template`, into whichever path you would like your new study directory to live.

The specific steps to copy the folder using the terminal are as follows:

.. code-block:: bash

    # log into spock or scotty
    ssh -XY username@spock.pni.princeton.edu
    ssh -XY username@scotty.pni.princeton.edu
    
    # copy the study template to your own path
    cp -r /jukebox/norman/pygers/handbook/new_study_template /jukebox/YOURLAB/USERNAME/...

    # rename new_study_template with your study name
    cd /jukebox/YOURLAB/USERNAME
    mv new_study_template [STUDYNAME]

Here is the hierarchy of the folders in the :blue:`new_study_template` folder. **Read the comments because if you don’t, none of the following steps will work!**

.. code-block:: bash

   $ tree

   └── new_study_template		# copy this directory to setup the entire directory structure for a new project
       └── code 
           └── preprocessing            # this is where heudiconv, fmriprep, mriqc scripts live
               └── license.txt          # SEE NOTE!
           └── analysis                 # [example] any other code can live at this level
           └── task                     # [example]
       └── data 
           └── bids                     # this is where raw BIDS data will be saved by HeuDiConv
               └── sub-001
               └── sub-002
               └── etc.
               └── derivatives          # this is where all your BIDS derivatives will be
                   └── deface           # defaced T1 images go here SEE NOTE!
                       └── logs         # slurm logs will go here
                   └── fmriprep         # fmriprep-preprocessed data will go here
                       └── logs         # slurm logs will go here
                   └── freesurfer       # fmriprep will also run freesurfer reconstruction and output goes here 
                   └── mriqc            # mriqc output will go here
                       └── logs         # slurm logs will go here
               └── .bidsignore          # similar to .gitignore, list all files/directories you don’t want to be checked by the bids-validator
           └── dicom                    # raw dicoms copied from the scanner go here
               └── check_volumes        # outputs checking that all dicoms transferred
           └── behavioral               # [example] any other data can live at this level

IMPORTANT NOTES:

* After copying the template directory for your new study, you need to update the paths in :blue:`globals.sh`. Open :blue:`globals.sh` and update the following three directories:
    * scanner_dir
    * project_dir
    * mounted_project_dir

* Before running fmriprep for the first time, you will need to download a FreeSurfer license file and save it in your :blue:`../code/preprocessing/` directory. If you decide to save it somewhere else (which is totally fine!), then you will need to update line 9 (--fs-license-file) of :blue:`run_fmriprep.sh` with the correct license file location.

    * `Get a FreeSurfer license here <https://surfer.nmr.mgh.harvard.edu/registration.html/>`_.

* Anatomical images need to be defaced before they can be shared publicly. We recommend defacing images as you collect data and saving them here, so they are available for you when you need them (e.g., data visualization in notebooks that may be shared publicly). Depending on the goals of your study, it may not be a good idea to preprocess your data using defaced images (e.g., it might introduce registration problems), so that is why we have them set aside in the derivatives directory here. 

Convert DICOMS to BIDS-formatted NIFTI
======================================

*Step 1: Convert your dicoms into nifti files using HeuDiConv*
----------------------------------------------------------------
This step will use the following four scripts (all of which can be found in :blue:`../code/preprocessing`):

* step1_preproc.sh
* number_of_files.py
* run_heudiconv.py
* deface.sh 

The script :blue:`step1_preproc.sh` will do five things for you: 

* copy your DICOM files from "conquest" and place them in your study directory (:blue:`../data/dicom/`)

* count the number of volumes in each run so you can check that your data transfer was successful (the output of this step can be found in :blue:`../data/dicom/check_volumes`)

* unzip the DICOMs in your study directory

* run HeuDiConv to convert your DICOMs (.dcm) to BIDS-formatted NIFTI files (.nii)

`HeuDiDonv is a flexible DICOM converter for organizing brain imaging data into structured directory layouts <https://heudiconv.readthedocs.io/en/latest/>`_.

* Deface your T1w anatomical image and set it aside in your derivatives directory (:blue:`../data/bids/derivatives/deface`)

You should run :blue:`step1_preproc.sh` for each subject and each session separately. You can run :blue:`step1_preproc.sh` as soon as your data have finished transferring from the scanner to the conquest directory (i.e., ~10 min after you finish scanning). 

The script takes three inputs: 

* subjectID
* sessionID
* the name of the data folder that contains your DICOM-images for that subject/session (at Princeton, this is in the “conquest” directory). You can get this information by listing the files in the conquest directory:

  * from Skyra: ``ls /jukebox/dicom/conquest/Skyra-AWP45031/NormaL/2020``
  * from Prisma: ``ls /jukebox/dicom/conquest/Prisma-MSTZ400D/NormaL/2020``

.. TIP::
    Add the above ls command as an alias in your .bashrc file to easily get this info when you need it:
    
    ``alias 'conquest'='ls /jukebox/dicom/conquest/Skyra-AWP45031/NormaL/2020'``

    Then instead of typing out the full conquest path every time you want to see the files in that directory, you can simply type *conquest* on your command line!

Whatever subjectID you use as your first input will be how your BIDS subject folders are named (eg., inputting 999 above will result in a directory called sub-999). SessionID (second input) should match how your runs were named on the scanner (e.g., input 01 for sessionID if your runs were named :blue:`func_ses-01_task-study_run-01`). *If your study doesn't include multiple sessions per subject, you will need to make some modifications to these scripts to remove the session information.* 

.. TIP::
    If you need to, run :blue:`step1_preproc.sh` line by line to check that the correct paths will go into :blue:`run_heudiconv.py`. If there is a problem with your paths, check your :blue:`globals.sh` file.

We recommended running :blue:`step1_preproc.sh` in a tmux window so you don’t run into issues with losing connection to the server, etc. After ssh-ing into the server, create a new tmux window OR attach to an exisiting tmux window. After creating a new window, you can attach to that specific window/session in the future. In other words, you don't have to create a new window every time you run :blue:`step1_preproc.sh`. 
    * Create a new tmux window: ``tmux new -s [name]``
    * Attach to an existing window: ``tmux a -t [name]``
    * NOTE: replace ``[name]`` with whatever you want to name your tmux window -- we recommend naming it *step1*.
    * `tmux cheatsheet <https://tmuxcheatsheet.com/>`_

.. code-block:: bash

    # attach to your tmux window
    tmux a -t step1

    # make sure you are in your study's code/preprocessing directory
    cd /jukebox/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing

    # list files available in conquest directory to get data folder name for input 3
    ls /jukebox/dicom/conquest/Skyra-AWP45031/NormaL/2020
    # OR
    ls /jukebox/dicom/conquest/Prisma-MSTZ400D/NormaL/2020

    # run the script step1_preproc.sh for subject 999, session 01
    ./step1_preproc.sh 999 01 [conquest folder name]

    # NOTE: For our sample project, use the following command
    ./step1_preproc.sh 001 01 0219191_mystudy-0219-1114

* If HeuDiConv is failing, check that your original dicoms are only zipped one time (meaning only one .gz extension instead of .gz.gz). If your dicoms are zipped multiple times, add another line for gunzipping again! Basically do this until your files only have the .dcm extension!

*Step 2: Get your data ready to pass bids-validation*
-----------------------------------------------------
This step will use the :blue:`step2_preproc.sh` script. We recommend running this step after data for all sessions for a given subject have been acquired and run through :blue:`step1_preproc.sh`.

This script will carry out all the "cleanup" steps that need to be taken to make sure your data are BIDS-valid and ready for MRIQC and FMRIPREP:  

* delete extra files (e.g., scouts, duplicate runs)

* rename fieldmaps (if necessary)

* add the IntendedFor field to the fieldmap .json files so that fieldmaps can be used for susceptibility distortion correction on your functional data

* run HeuDiConv to convert your DICOMs (.dcm) to BIDS-formatted NIFTI files (.nii)

The script takes one input: 

* subjectID

.. NOTE::
  * This script will need to be customized for your study! Edit this script once at the beginning of your project so that all the filenames match your naming scheme, and so the fieldmaps are being applied to the correct functional runs.

  * If an individual subject deviates from your standard (e.g., has an extra set of fieldmaps or is missing functional runs), then you will need to edit :blue:`step2_preproc.sh` again to accomodate these differences. 

If you run bids-validator and get any warnings and/or errors, put any modifications you need to make to pass the validator into this script so you can easily get subjects ready for BIDS apps as you collect more subjects. **Again, this script should be customized for your experiment and not just run without editing.**

.. code-block:: bash

    # run the script (step2_preproc.sh), e.g. for subject 999
    ./step2_preproc.sh 999

    # NOTE: For our sample project, use the following command
    ./step2_preproc.sh 001

*Step 3: Run the BIDS validator*
--------------------------------
Run the BIDS validator to make sure everything is setup correctly. You should check your BIDS validation as soon as possible (i.e., after collecting your first subject's data) so that you can fix any problems if they exist! 

Any non-BIDS formatted files should go into your :blue:`../bids/derivatives` directory which is automatically ignored by the BIDS validator; if you (deliberately) have non-BIDS formatted files outside of the derivatives folder, then you can add them to a :blue:`.bidsignore` file.

You can run the BIDS validator `from your browser <http://bids-standard.github.io/bids-validator/>`_.  

OR you can install the bids-validator and run it *locally*:

* First, make sure you have Node.js (10.11.0 or above) installed on your local machine. Open a local terminal window and from your home directory type: 

.. code-block:: bash

    node -v

`Install node and npm if needed <https://blog.teamtreehouse.com/install-node-js-npm-mac>`_.

* Install the bids-validator. From your home directory run the following:

.. code-block:: bash

    npm install bids-validator
 
* Then you can check to make sure it’s there:
  
.. code-block:: bash

    bids-validator -v
    # OR
    which bids-validator

`More information about the bids validator installation can be found here <httpps://github.com/bids-standard/bids-validator>`_

* This installs bids-validator in :blue:`~/node_modules/.bin`. You can more easily call this by adding an alias to your :blue:`~/.bashrc` configuration file, e.g.: 

.. code-block:: bash

    alias 'bids-validator'='~/node_modules/.bin/bids-validator'

* Even though you will run the BIDS validator from your local machine, it needs to access your bids directory on the server. You will need to `mount jukebox on your desktop <https://npcdocs.princeton.edu/index.php/Mounting_the_PNI_file_server_on_your_desktop>`_. 

* Run the bids-validator from your *local* terminal window:

.. code-block:: bash

    bids-validator /Volumes/YOURLAB/USERNAME/YOURSTUDY/data/bids

Read the red “errors” and yellow "warnings". At the bare minimum, you will need to fix the "errors" before you continue. Re-run until the Validator is appeased. Note that “warnings” can be ignored, but you’ll probably want to fix them at some point.

*Step 4: Deface anatomical images*
----------------------------------
Eventually, if you want to share de-identified data, you will need to deface anatomical images. You do not want to use the defaced images for any further preprocessing step (unless you are certain it won't mess up a downstream preprocessing or analysis step). So after defacing the images, we will set them aside in the :blue:`../data/bids/derivatives/deface` so they are available whenever you need them. 

IMPORTANT: This defacing step is included in :blue:`step1_preproc.sh`! We are including additional instructions here in case you would like to run it separately. However, you do not need to continue with this step if you left it as is as part of :blue:`step1_preproc.sh`.

The :blue:`deface.sh` script will run `pydeface <https://github.com/poldracklab/pydeface>`_ to deface the T1w structural images and move the defaced image into your :blue:`../data/T1w_defaced` directory. It takes two inputs:

* subjectID
* sessionID

*Running pydeface on the cluster:*

To run pydeface on the head node, we recommend using a tmux window (it takes ~9 min to deface one image).

.. code-block:: bash
    
    # open a new tmux window called deface
    tmux new -s deface 
    # OR  attach to a previously opened window called deface
    tmux a -t deface

    # move into your code directory
    cd /jukebox/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing

    # call deface script
    ./deface.sh 999 01 #example is subject 999, session 01

You can also run pydeface using SLURM, which is especially useful if you want to run this step for multiple subjects and/or multiple sessions all at once. The script that we will call to run a job on SLURM is :blue:`code/preprocessing/slurm_deface.sh`.

* Update lines in slurm_deface.sh: 
    * Line 7: array number should be equal to all the subject numbers you want to run the script on (if you enter multiple, it will run them all in parallel) e.g., array=101,102,104 
    * Lines 23 -24: update if you want to get an email with the update on the code
    * Line 39: change if you want to run on a different session besides session 1

.. TIP::
    In SLURM scripts, lines that start with ``#SBATCH`` are SLURM commands, not comments! All other lines that start with ``#`` are regular comments. 

To submit the job:

.. code-block:: bash
    
    # move into your code directory
    cd /jukebox/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing

    # submit the job
    sbatch slurm_deface.sh

Note you don't have to include the subjectID and sessionID inputs here because you defined this information in the :blue:`slurm_deface.sh` script itself. 

*Running pydeface on your local machine:*

Make sure `pydeface <https://github.com/poldracklab/pydeface>`_ is installed on your local machine. Pydeface will only work if python 3 is the default on your machine (not python 2.7). To install:

.. code-block:: bash

    git clone https://github.com/poldracklab/pydeface.git
    cd pydeface
    python setup.py install

`Mount jukebox on your desktop <https://npcdocs.princeton.edu/index.php/Mounting_the_PNI_file_server_on_your_desktop>`_. 

Then, from a *local* Terminal window:

.. code-block:: bash

    # move into your code/preprocessing directory
    cd /Volumes/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing

    # run deface script with 2 inputs
    ./deface.sh 999 01 #example is subject 999, session 01

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html
