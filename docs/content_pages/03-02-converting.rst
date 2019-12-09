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

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html

















