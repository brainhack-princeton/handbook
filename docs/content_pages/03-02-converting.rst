.. _converting:

=======================
Converting data to BIDS
=======================

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

Convert dicoms to BIDS-formatted Nifti
======================================

The first step once you have the DICOM-images of your experiment in the BIDS-format is to convert your dicoms into nifti-images and, in the case you have acquired fieldmaps, to make sure the fieldmap corrections are applied to the correct functional runs.

*Step 1: Setting up your directory structure*
---------------------------------------------

Getting data off the scanner in a BIDS-formatted way requires that your directories are made in a specific way. To make things simpler, we have made the folders already for you. Copy the folder :blue:`new_study_template` into whichever path you would like. The location is :blue:`/jukebox/norman/pygers/handbook/new_study_template`.

The specific steps to copy the folder using the terminal are as follows:

.. code-block:: bash

    # log into spock or scotty
    ssh username@spock.pni.princeton.edu
    ssh username@scotty.pni.princeton.edu
    # copy the study template to your own path
    cp -r /jukebox/norman/pygers/handbook/new_study_template /jukebox/YOURLAB/username/

Here is the heirarchy of the folders in the :blue:`new_study_template` folder. **Read the footnotes because if you don’t, none of the following steps will work!**

.. code-block:: bash

   $ tree

   └── new_study_template		# copy this directory to setup the entire directory structure for a new project
       └── code 
           └── preprocessing            # SEE FOOTNOTE 1. this is where heudiconv, fmriprep, etc. scripts live
               └── license.txt          # SEE FOOTNOTE 2. download a freesurfer license file and save here
           └── analysis                 # [example] any other code can live at this level
           └── task                     # [example]
       └── data 
           └── bids                     # this is where raw BIDS data will be saved by HeudiConv
               └── sub-001
               └── sub-002
               └── etc.
               └── derivatives          # this is where all your BIDS derivatives will be
                   └── mriqc            # mriqc output will go here
                       └── logs         # slurm logs will go here
                   └── fmriprep         # fmriprep-preprocessed data will go here
                       └── logs         # slurm logs will go here
                   └── freesurfer
               └── .bidsignore          # similar to .gitignore, list all files/directories you don’t want to be checked by the bids validator
           └── dicom                    # raw dicoms copied from the scanner go here
               └── check_volumes        # outputs checking that all dicoms transferred
           └── T1w_defaced              # SEE FOOTNOTE 3. defaced T1 images
           └── behavioral               # [example] any other data can live at this level

*Step 2: Convert your dicoms into nifti files through heudiconv*
----------------------------------------------------------------

The script step1_preproc.sh (in new_study_template/code/preprocessing) needs your dicom images as input, unzips them, and converts them to nifti-images (fitting within the BIDS format) using heudiconv. You run this script for each subject and each session separately. `Heudiconv is a flexible DICOM converter for organizing brain imaging data into structured directory layouts <https://heudiconv.readthedocs.io/en/latest/>`_. 

It needs three inputs: 
1. subjectID
2. sessionID
3. the name of the directory that contains your DICOM-images of that subject/session (at Princeton, this is in the “conquest” directory). 

The step1_preproc.sh script will also need the number_of_files.py script and run_heudiconv.py script (also in :blue:`new_study_template/code/preprocessing`).

Before running the first time, you should make sure that you have properly updated your paths. If you need to, run :blue:`step1_preproc.sh` line by line to check that the correct paths will go into :blue:`run_heudiconv.py`. If you have not already done this, follow footnote 2 above and update :blue:`globals.sh` with your directory info!

.. code-block:: bash

    # make sure you're in the preprocessing directory
    cd /Volumes/YOURLAB/USERNAME/new_study_template/code/preprocessing
    # run the script step1_preproc.sh for session 01 and subject 999
    ./step1_preproc.sh 999 01 [conquest folder name]

    # NOTE: For our sample project, use the following command
    ./step1_preproc.sh 001 01 0219191_mystudy-0219-1114

Other things to know:

* Whatever subjectID you use as your first input, that will be how your BIDS subject folders are named (eg., inputting 999 above will result in a directory called sub-999). SessionID (second input) should match how your runs were named on the scanner (e.g., input 01 for sessionID if your runs were named :blue:`func_ses-01_task-study_run-01`).
* Recommended to run this in a tmux window so you don’t run into issues with losing connection to server, etc. After ssh-ing into the server, run the following to create or attach to a tmux window (NOTE: replace [name] with whatever you want to call the new tmux session you are opening, then you can attach to that specific window/session in the future):
    * Create a new tmux window: ``tmux new -s [name]``
    * Attach to an existing window: ``tmux a -t [name]``
* To check name of subject folders on conquest: 
    * Skyra - ``ls /jukebox/dicom/conquest/Skyra-AWP45031/NormaL/2019``
    * Prisma - ``ls /jukebox/dicom/conquest/Prisma-MSTZ400D/NormaL/2019``
* If heudiconv is failing, check that your original dicoms are only zipped one time (meaning .gz is the only extension instead of .gz.gz). If your dicoms are zipped multiple times, add another line for gunzipping again! Basically do this until you have dcm’s!

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html

















