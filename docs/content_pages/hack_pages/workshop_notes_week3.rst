:orphan:

==========================================
Pygers Workshop Notes - Week 3 (Fall 2020)
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

What is BIDS? Why do we use it?
--------------------------------

`The Brain Imaging Data Structure <https://bids.neuroimaging.io/>`_, or *BIDS*, is a **standardized way of organizing neuroimaging data**. 

ReproIn: Setting yourself up for success
----------------------------------------

DICOM and NIFTI formats
-----------------------

Your data comes off the scanner in dicom format. At PNI, data from the scanner is transferred to a directory on jukebox called 'conquest'. 

.. code-block:: bash

    # take a look around conquest
    $ cd /jukebox/dicom/conquest
    $ ls
    $ cd Skyra-AWP45031/NormaL/2020/
    $ ls # RIP scanning in 2020

    # for our sample data, we have made a "fake" conquest directory
    $ cd /jukebox/norman/pygers/conquest/
    $ ls
    $ cd 0219191_mystudy-0219-1114/dcm
    $ ls

The important thing to remember about dicom files is they contain identifying information about the subject!! e.g. date and time of the scan and birthdate. In other words, you probably do not want to share dicom files publicly unless you have specific permission to do so (or have removed identifying information from the headers). 

.. code-block:: bash

    # you can use AFNI to read dicom header information 
    # NOTE: your dicoms need to be unzipped first (we will do this in the step1_preproc step below)
    $ module load afni
    $ dicom_hdr FILENAME.dcm

Talk about nifti file format...

.. code-block:: bash
    
    # you can use AFNI to read nifti header
    $ nifti_tool -disp_hdr -infiles FILENAME.nii.gz

    # you can also use FSL
    $ module load fsl
    $ fslhd FILENAME.nii.gz #full header information
    $ fslinfo FILENAME.nii.gz #abbreviated header information

Preparing to run HeuDiConv
--------------------------

*HeuDiConv* (i.e. the Heuristic Dicom Converter) is a **package that we use to convert dicom files to BIDS-formatted nifti files**. 

There are a few steps that need to be taken before we can run heudiconv. We have packaged these steps into a script called :blue:`step1_preproc.sh`. There is detailed documentation of the :blue:`step1_preproc.sh` script on our `Converting data to BIDS using HeuDiConv <../03-01-converting.html>`_ handbook page. 

.. code-block:: bash

    # update our conda environment and install the pydeface package
    $ conda update -n base -c defaults conda
    $ conda activate pygers
    $ pip install pydeface

    # Make your life easier!
    # add a conquest alias to .bashrc or .bash_profile
    $ vim ~/.bashrc #if you are on the server
    # vim ~/.bash_profile if you are on your local machine

    # enter insert mode (i) and add the following:
    # alias 'conquest'='ls /jukebox/norman/pygers/conquest'
    # go back to command mode (esc)
    # :x to save and exit

    $ source .bashrc
    $ conquest

    # update the version of heudiconv in run_heudiconv.py
    $ pygers #this is an alias to cd to your pygers_workshop directory!
    $ cd sample_study/code/preprocessing
    $ vim run_heudiconv.py

    # enter insert mode (i) and update line 18:
    # "/jukebox/hasson/singularity/heudiconv/heudiconv-v0.8.0.simg "
    # go back to command mode (esc)
    # :x to save and exit

    # commit those changes using git
    $ git status
    $ git add run_heudiconv.py
    $ git commit -m "update heudiconv version"

    # remove module load pydeface from deface.sh
    $ vim deface.sh

    # enter insert mode (i) and update line 6:
    # remove or comment out module load pydeface/2.0.0
    # go back to command mode (esc)
    # :x to save and exit

    # do the same for deface_template.sh
    $ vim deface_template.sh

    # commit and push changes using git
    $ git status
    $ git add deface.sh
    $ git add deface_template.sh
    $ git commit -m "remove module load pydeface"
    $ git status
    $ git push -u origin master

Running HeuDiConv
-----------------

.. code-block:: bash

    # create a tmux session
    $ tmux new -s heudiconv

    # practice using tmux:
    # detach using ctrl+b, d
    # attach to an existing session
    $ tmux a -t heudiconv

    # in your tmux window, make sure you are in your code/preprocessing directory
    $ pwd

    # activate your conda environment in your tmux session!
    $ conda activate pygers

    # get the name of the conquest directory that contains the dicom files you want to convert
    $ conquest #using our alias!

    # run step1_preproc.sh with 3 inputs:
    # (1) subject ID
    # (2) session ID
    # (3) conquest directory
    $ ./step1_preproc.sh 001 01 0219191_mystudy-0219-1114

`Return to workshop info <./syllabus2020.html>`_

