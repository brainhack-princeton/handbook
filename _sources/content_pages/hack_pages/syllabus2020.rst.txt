:orphan:

=========================
Fall 2020 Pygers Workshop
=========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Building a reproducible neuroimaging pipeline: From acquisition to analysis
===========================================================================

This is a weekly hands-on workshop series designed to introduce you to the tools and best practices foundational to building a reproducible neuroimaging pipeline. This workshop is open to researchers of all levels, no prior experience necessary! You do not need your own data as the demos will use our `sample dataset <../01-03-sampleProjectWithBIDS.html>`_, but we certainly hope you will apply the framework covered here to your own data. During the workshop, we will be demo-ing on our (Mac OS) computers (via screen share), and we strongly recommend you try to follow along on your own computer. Each week's lesson will build off of the last.

The tentative workshop syllabus is included below, but please be aware that dates may change if we end up needing more than one week to cover a given set of topics. The workshop will take place via Zoom on **Thursdays from 10-11am EST**.   

Please **subscribe to the pygers listserv** to get email announcements and zoom links!

* Send an email to listserv@princeton.edu from the email you want to be subscribed.
* In the body of the email, type **SUB pygers**
* Make sure there is no subject or any other text in the body and then send the email. 
* You should receive a response.
* If the above method does not work, please email snastase@princeton.edu to be added manually.  

Workshop Overview
=================

Week 1: Intro to high performance computing at PNI and Terminal basics
----------------------------------------------------------------------
**Date: Thursday, October 8 10-11am EST**

**Topics Covered:**

* server/cluster jargon
* how to use PNI's file server and cluster
* bash commands
* using `vim <https://vim.rtorr.com/>`_
* setting up aliases in .bashrc
* setting up a `conda <https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html>`_ environment and installing packages

**Preparation:**

* *If you are at PNI*, make sure you have access to the PNI server (i.e., request a `PNI NetID <https://frevvo-prod.princeton.edu/frevvo/web/tn/pu.nplc/u/84fd5e8d-587a-4f6a-a802-0c3d2819e8fe/app/_sO14QHzSEemyQZ_M7RLPOg/formtype/_b4L9oHz4EemyQZ_M7RLPOg/popupform>`_). After requesting your PNI NetID, follow the provided instructions to login and setup your password. 

* *If you are not at PNI*, figure out where you workshop working directory to live. This can be your local machine or if you have access to a server at your home institution that you normally use for data processing and analysis, you may want to work there. Either way, follow the instructions to `download the sample data <../01-03-sampleProjectWithBIDS.html>`_ and save it in your desired working directory (i.e., a directory on your local machine or a server). Note, if you have PNI server access you do not need to download the sample data ahead of time. 

* If you do not already have it, download and install `XQuartz <https://www.xquartz.org/>`_ on your local machine. After installing, you will need to log out of your account and then log back in (or just Restart your computer). Then open a Terminal and type: 

.. code-block:: bash

	defaults write org.macosforge.xquartz.X11 enable_iglx -bool true

* Download and install a text editor on your local machine (recommended: `Sublime Text <https://www.sublimetext.com/>`_). 

Week 2: Using Git and GitHub
----------------------------
**Date: Thursday, October 15 10-11am EST**

**Topics Covered:**

* initializing Git
* setting up a GitHub repository
* using .gitignore
* general Git workflow, including important git commands

**Preparation:**

* Sign up for an account on `GitHub <https://www.github.com/>`_ if you do not already have one
* Background reading: `Overview of Git and version control <https://guides.github.com/introduction/git-handbook/>`_ 

Week 3: Understanding MRI data formats and standardizing your dataset structure
-------------------------------------------------------------------------------
**Date: Thursday, October 22 10-11am EST**

**Topics Covered:**

* What is BIDS?
* Using the `ReproIn <https://github.com/nipy/heudiconv/blob/master/heudiconv/heuristics/reproin.py>`_ heuristic to setup your program card prior to data acquisition
* dicom and nifti formats
* Using HeuDiConv to convert raw data to a BIDS-compliant data structure
* Using `tmux <./tmux.html>`_ to create persistent server sessions
* Defacing images using pydeface

**Preparation:**

* `The benefits of BIDS <https://www.youtube.com/watch?v=K9hVAr5fvJg&feature=youtu.be&ab_channel=OHBMOpenScienceSIG>`_. This is Sam's OHBM TrainTrack presentation (~70 minutes). 
* Handbook reading: `Using tmux to create persistent server sessions <./tmux.html>`_

* *If you do not have PNI server access*, build your own HeuDiConv singularity image

.. code-block:: bash

	we will provide code here

Week 4: Preparing your data to run BIDS apps (MRIQC and fMRIPrep)
-----------------------------------------------------------------
**Date: Thursday, October 29 10-11am EST**

**Topics:**

* Data visualization
* Using the `BIDS Validator <https://bids-standard.github.io/bids-validator/>`_
* Using SLURM to schedule jobs on the server

**Preparation:**

* Install a local version of `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/MacOsX>`_ and/or `AFNI <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/index.html>`_ (your choice!)

* *If you do not have PNI server access*, build your own MRIQC and fMRIPrep singularity images

.. code-block:: bash

	we will provide code here

Week 5: Understanding MRIQC and fMRIPrep outputs
------------------------------------------------
**Date: Thursday, November 5 10-11am EST**

**Topics:**

* `MRIQC <https://mriqc.readthedocs.io/en/stable/>`_ for data quality assurance 
* `fMRIPrep <https://fmriprep.org/en/stable/>`_ for data preprocessing

**Preparation:**

Week 6: Version controlling your data
-------------------------------------
**Date: Thursday, November 12 10-11am EST**

**Topics:**

* `DataLad <https://www.datalad.org/>`_ for data version control

**Preparation:**

* Check out the `DataLad Handbook <http://handbook.datalad.org/en/latest/>`_!


