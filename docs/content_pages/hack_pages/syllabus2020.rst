:orphan:

=========================
Fall 2020 Pygers Workshop
=========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Organized by: Lizzie McDevitt, Sam Nastase, Paula Brooks

Contact info: emcdevitt8287@gmail.com, sam.nastase@gmail.com, paulapbrooks@gmail.com

Building a reproducible neuroimaging pipeline: From acquisition to analysis
===========================================================================

This is a weekly hands-on workshop series designed to introduce you to the tools and best practices foundational to building a reproducible neuroimaging pipeline. This workshop is open to researchers of all levels, no prior experience necessary! You do not need your own data as the demos will use our `sample dataset <../01-03-sampleProjectWithBIDS.html>`_, but we certainly hope you will apply the framework covered here to your own data. During the workshop, we will be demo-ing on our (Mac OS) computers, and we strongly recommend you try to follow along on your own computer. Each week's lesson will build off of the last.

The tentative workshop schedule is included below, but please be aware that dates may change if we end up needing more than one week to cover a given set of topics. The workshop will take place via Zoom on **Thursdays from 10-11am EST**.   

Please **subscribe to the pygers listserv** to get email announcements and Zoom links!

1. Send an email to listserv@princeton.edu from the email you want to be subscribed.
2. In the body of the email, type **SUB pygers**
3. Make sure there is no subject or any other text in the body and then send the email. You should receive a response. 
4. If the above method does not work, please email sam.nastase@gmail.com to be added manually.  

Workshop Overview
=================

Week 1: Intro to high performance computing at PNI and Terminal basics
----------------------------------------------------------------------
`Week 1 Notes <./workshop_notes_week1.html>`_

`Week 1 Recording <https://drive.google.com/file/d/13m0NUQYX5JDxHNQvTvfIzFUERdr0x34J/view?usp=sharing>`_

**Date: Thursday, October 8 10-11am EST**

**Topics Covered:**

* server/cluster jargon
* how to use PNI's file server and cluster
* `bash commands <https://appletree.or.kr/quick_reference_cards/Unix-Linux/Linux%20Command%20Line%20Cheat%20Sheet.pdf>`_
* using `vim <https://vim.rtorr.com/>`_
* setting up aliases in .bash_profile and .bashrc
* setting up a `conda <https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html>`_ environment and installing packages (we didn't get to this in week 1; we will start with this at the beginning of week 2)

**Preparation (try to complete these agenda items prior to the Thursday workshop):**

1. *If you are at PNI*, make sure you have access to the PNI server (i.e., request a `PNI NetID <https://frevvo-prod.princeton.edu/frevvo/web/tn/pu.nplc/u/84fd5e8d-587a-4f6a-a802-0c3d2819e8fe/app/_sO14QHzSEemyQZ_M7RLPOg/formtype/_b4L9oHz4EemyQZ_M7RLPOg/popupform>`_). After requesting your PNI NetID, follow the provided instructions to login and setup your password. 

2. *If you do not have PNI server access*, figure out where you want your working directory for the workshop to live. This can be on your local machine, or if you have access to a server at your home institution that you normally use for data processing/analysis, you may want to work there. Either way, name your working directory :blue:`pygers_workshop`. Follow the instructions to `download the sample data <../01-03-sampleProjectWithBIDS.html>`_ and save it in your :blue:`pygers_workshop` working directory. Note, if you have PNI server access you do not need to download the sample data ahead of time. 

3. *If you do not have PNI server access*, download the :blue:`new_study_template` folder available on `Google Drive <https://drive.google.com/drive/folders/1w-UIlPSctf-XM3Xv1PBQtipWCfYd0mmc?usp=sharing>`_. Save it in the same :blue:`pygers_workshop` working directory as the downloaded sample data. Rename the folder :blue:`new_study_template` to :blue:`sample_study`. 

4. *If you are using a Windows machine*, you should consider `installing a Windows subsystem for Linux <https://docs.microsoft.com/en-us/windows/wsl/install-win10>`_. When choosing your Linux distribution, choose the newest version of Ubuntu LTS. 

5. *If you are using a Mac*: If you do not already have it, download and install `XQuartz <https://www.xquartz.org/>`_ on your local machine. After installing, you will need to log out of your computer's user account and then log back in (or just restart your computer). Then open a Terminal and type: 

.. code-block:: bash

	defaults write org.macosforge.xquartz.X11 enable_iglx -bool true

6. *Everyone*: Download and install a text editor on your local machine (recommended: `Sublime Text <https://www.sublimetext.com/>`_). 

Week 2: Using Git and GitHub
----------------------------
`Week 2 Notes <./workshop_notes_week2.html>`_

`Week 2 Recording <https://drive.google.com/file/d/1ZOHSzpozPh2OP8Nvq2h1lDbMdmuUuT0Q/view?usp=sharing>`_

**Date: Thursday, October 15 10-11am EST**

**Topics Covered:**

* setting up a `conda <https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html>`_ environment and installing packages
* initializing Git
* setting up a GitHub repository
* using .gitignore
* general Git workflow, including important Git commands

**Preparation:**

1. Sign up for an account on `GitHub <https://www.github.com/>`_ if you don't have one already
2. Background reading: `Overview of Git and version control <https://guides.github.com/introduction/git-handbook/>`_ 

Week 3: Understanding MRI data formats and standardizing your dataset structure
-------------------------------------------------------------------------------
`Week 3 Notes <./workshop_notes_week3.html>`_

`Week 3 Recording <https://drive.google.com/file/d/1a5qXJWU2FTJr6ZdK2I1RRkd1-ReZNhBb/view?usp=sharing>`_

**Date: Thursday, October 22 10-11am EST**

**Topics Covered:**

* What is BIDS?
* Using the `ReproIn <https://github.com/nipy/heudiconv/blob/master/heudiconv/heuristics/reproin.py>`_ heuristic to setup your program card prior to data acquisition
* dicom and nifti formats
* Using HeuDiConv to convert raw data to a BIDS-compliant data structure
* Using `tmux <./tmux.html>`_ to create persistent server sessions
* Defacing images using pydeface

**Preparation:**

1. `The benefits of BIDS <https://www.youtube.com/watch?v=K9hVAr5fvJg&feature=youtu.be&ab_channel=OHBMOpenScienceSIG>`_. This is Sam's OHBM TrainTrack presentation (~70 minutes). 

2. Handbook reading: `Using tmux to create persistent server sessions <./tmux.html>`_

3. *If you do not have PNI server access*, install a local version of `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/MacOsX>`_.

4. *Optional: If you are working on your home institution's server*: If `Singularity <https://sylabs.io/singularity/>`_ is available on your server, you can use it to build your own heudiconv Singularity image that can live on your institution's server. 

.. code-block:: bash

	singularity pull docker://nipy/heudiconv 

Week 4: Preparing your data to run BIDS apps (MRIQC and fMRIPrep)
-----------------------------------------------------------------
`Week 4 Notes <./workshop_notes_week4.html>`_

`Week 4 Recording <https://drive.google.com/file/d/1A5MQlOHGeQ4JE_NmcxT04g2waoI98YcE/view?usp=sharing>`_

**Date: Thursday, October 29 10-11am EST**

**Topics Covered:**

* Exploring the outputs of HeuDiConv
* Data visualization using FSLeyes and AFNI
* Using the `BIDS Validator <https://bids-standard.github.io/bids-validator/>`_

**Preparation:**

1. *Everybody, even if you have been working on the PNI server*: We recommend that you have a local version of FSLeyes available. This is because *remotely* accessing the module on the PNI server to view images is quite slow and clunky. It is much faster to use a local version of FSLeyes. You can either a) install a local version of `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/MacOsX>`_, which includes FSLeyes (if you already have a local FSL installed after last week you are good to go!) OR b) install conda on your local machine (you can follow the instructions for Local installation in our `Week 2 Notes <./workshop_notes_week2.html>`_) and create a new local conda environment. After creating your new conda environment, you can install the FSLeyes package (you don't need to install the git, numpy, pandas, jupyter packages from Week 2 unless you want to). 

.. code-block:: bash

	conda install -c conda-forge fsleyes 

Week 5: Running MRIQC and fMRIPrep
----------------------------------

`Week 5 Notes <./workshop_notes_week5.html>`_

Week 5 Recording (not yet available)

**Date: Thursday, November 5 10-11am EST**

**Topics Covered:**

* Using SLURM to schedule jobs on the PNI server
* Running `MRIQC <https://mriqc.readthedocs.io/en/stable/>`_ for data quality control
* Running `fMRIPrep <https://fmriprep.org/en/stable/>`_ for data preprocessing
* Exploring MRIQC outputs
* Exploring fMRIPrep outputs

**Preparation:**

1. *Everybody*: Make sure you are caught up thru week 4!   

2. *Everybody*: `Download a FreeSurfer license key <https://surfer.nmr.mgh.harvard.edu/registration.html>`_ and save it in your :blue:`pygers_workshop/sample_study/code/preprocessing` directory. If you have previously downloaded a FreeSurfer license, you can simply save a copy of the same license file in this location.

3. *Everybody, Optional*: If you want to get a head start on week 5 content, follow the instructions in the section titled, "Preparing to run MRIQC and fMRIPrep" in the `Week 5 notes <./workshop_notes_week5.html>`_ to (i) setup your work directory on `scratch` and (ii) edit the following scripts: `globals.sh`, `deface_template.sh`, `run_mriqc.sh`, `run_mriqc_group.sh`, `run_fmriprep.sh`.

4. *Optional: If you are working on a non-PNI server*: If `Singularity <https://sylabs.io/singularity/>`_ is available on your server, you can use it to build your own MRIQC and fMRIPrep Singularity images that can live on your institution's server. 

.. code-block:: bash

	singularity build mriqc-0.15.1.simg docker://poldracklab/mriqc:0.15.1

	singularity build fmriprep-v20.2.0.simg docker://poldracklab/fmriprep:20.2.0

5. *Optional: If you want to run MRIQC and fMRIPrep locally*, it is recommended you use Docker. `MRIQC Docker instruction are found here <https://mriqc.readthedocs.io/en/0.15.1/docker.html#>`_. `fMRIPrep Docker  instructions are found here <https://fmriprep.org/en/stable/installation.html#container-technologies-docker-and-singularity>`_.

Week 6: Version controlling your data
-------------------------------------
**Date: Thursday, November 12 10-11am EST**

**Topics Covered:**

* `DataLad <https://www.datalad.org/>`_ for data version control

**Preparation:**

1. Check out the `DataLad Handbook <http://handbook.datalad.org/en/latest/>`_!


