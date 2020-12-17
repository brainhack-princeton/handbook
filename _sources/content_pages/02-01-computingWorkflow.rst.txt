.. _computingWorkflow:

===================================================
Best practices for building a reproducible workflow 
===================================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

There are many resources and tools available to us for making our science more open and reproducible. However, it can be quite overwhelming thinking about how to incorporate each thing in your daily workflow! 

Below we have outlined some of the tools we think are most useful to learn or become acquainted with, organized by the “stage” in your workflow you would want to think about incorporating these tools. For many of these tools, we have linked handbook pages with tips or tutorials to help you get started using them. 

Another great way to get started with several of these tools is by following along with our `Pygers Workshop recordings and notes <pygers_workshops/syllabus2020.html>`_.  

Setting up your computing environment
=====================================

1. :ref:`Tips for using the command line` (tmux, vim)
2. :ref:`Conda environments`
3. :ref:`Git and GitHub`
4. :ref:`Get started programming with Python` (Jupyter notebooks, iPython debugger)
5. :ref:`Using Slurm`

Prepare for data acquisition
============================

6. :ref:`Preregister your study` (OSF, AsPredicted)
7. :ref:`Design your scan sequences`
8. :ref:`Setup your program card using ReproIn`
9. :ref:`Setup your protocol` (Protocols.io)

Data collection
===============

10. :ref:`Convert your raw data to BIDS` (HeuDiConv)
11. :ref:`Data quality assurance` (MRIQC)
12. :ref:`Preprocessing` (fMRIPrep)
13. :ref:`Data version control` (DataLad)
14. :ref:`Data visualization`

Data analysis
=============

15. :ref:`fMRI analysis software packages` (AFNI, FSL)
16. :ref:`Python packages` (Nilearn, scikitlearn, Nibabel, BrainIAK)
17. :ref:`BrainIAK tutorials`

Publishing and data sharing
===========================

18. :ref:`Overleaf`
19. :ref:`Code Ocean`

.. _Tips for using the command line:

Tips for using the command line
-------------------------------

The sooner you become comfortable using the command line the better! Here are some helpful tips for using the command line to `navigate the PNI server <hack_pages/find-your-data.html>`_.

**tmux:** When working on a remote server (like scotty at PNI), you can use tmux to create persistent remote sessions. If you get disconnected from the remote server, the tmux session will keep running. You can attach and detach from these remote sessions, and create multiple windows or panes in a given session. You can control tmux using key combinations; you first type a prefix key combination (by default ctrl + b) followed by additional command keys. See our `tmux tip page <hack_pages/tmux.html>`_ for a tutorial on using tmux.

**Vim:** 

.. _Conda environments:

Conda environments
------------------

Conda is a **package manager**, similar to brew, apt, or pip. This package manager keeps track of your Python installation, versions, and dependencies in an encapsulated **environment** that can be easily shared or reproduced. This is helpful if you have multiple projects that require different (potentially conflicting) software versions. You can easily switch between different conda environments. 

**Best practice recommendation**: Setup a new conda environment for each of your projects; always use that conda environment when working on that project. This way you can ensure your software versions are consistent within a project and you can easily report which specific versions you used. 

See our `conda tip page <hack_pages/conda.html>`_ for instructions to setup a “pygers” conda environment with our recommended packages installed. 

.. _Git and GitHub:

Git and GitHub
--------------

See our `git tip page <hack_pages/git.html>`_ for a tutorial on using Git and GitHub.

.. _Get started programming with Python:

Get started programming with Python
-----------------------------------
**Jupyter notebooks**:

See our `Jupyter notebook tip page <hack_pages/jupyter.html>`_ for a tutorial on using Jupyter notebook.

**iPython debugger**:

See our `ipdb tip page <hack_pages/debugging-workflow.html>`_ for a tutorial on using the iPython debugger.

.. _Using Slurm:

Using Slurm
-----------

See our `Slurm tip page <hack_pages/slurm.html>`_ for a tutorial on using Slurm.

.. _Preregister your study:

Preregister your study
----------------------
Add description

`Open Science Framework <research_tools/osf.html>`_.

.. _Design your scan sequences:

Design your scan sequences
--------------------------
Add description

`Choosing your acquisition parameters <./02-03-acquisitionParams.html>`_.

.. _Setup your program card using ReproIn:

Setup your program card using ReproIn
-------------------------------------
Add description

`Using ReproIn <./02-04-reproin.html>`_.

.. _Setup your protocol:

Setup your protocol
-------------------

`Protocols.io <research_tools/protocols_io.html>`_.


.. _Convert your raw data to BIDS:

Convert your raw data to BIDS
-----------------------------
Add description

`Using HeuDiConv <./03-02-converting.html>`_.

.. _Data quality assurance:

Data quality assurance
----------------------
Add description

`Using MRIQC <./03-03-mriqc.html>`_.

.. _Preprocessing:

Preprocessing
-------------
Add description

`Using fMRIPrep <./03-04-fmriprep.html>`_.

.. _Data version control:

Data version control
--------------------
Add description

`Using DataLad <./03-06-sampleProjectWithDatalad.html>`_.

.. _Data visualization:

Data visualization
--------------------
Add description

.. _fMRI analysis software packages:

fMRI analysis software packages
-------------------------------
Add description

.. _Python packages:

Python packages
---------------
Add description

.. _BrainIAK tutorials:

BrainIAK tutorials
------------------
Add description

`Link to BrainIAK tutorials <https://brainiak.org/tutorials/>`_

.. _Overleaf:

Overleaf
--------
Add description

`Using Overleaf at Princeton <research_tools/overleaf.html>`_.

.. _Code Ocean:

Code Ocean
----------
Add description

`Using Code Ocean <research_tools/code_ocean.html>`_.


.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html



