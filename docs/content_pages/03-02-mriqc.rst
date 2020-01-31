.. _mriqc:

==========================
Quality control with MRIQC
==========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Quality checks (MRIQC)
----------------------

To get an idea of the quality of your fMRI data, you can use the MRI Quality Check (MRIQC) which is the script slurm_mriqc.sh (which you can find in :blue:`/jukebox/norman/pygers/handbook/code/`). This script will need ``run_mriqc.sh`` and ``run_mriqc_group.sh``. This script will run mriqc (quality metrics) for an individual subject followed by the group summary statistics using slurm. 

Before running for the first time:

* Open slurm_mriqc.sh and update the array number to be your subject number (you can run multiple subjects at the same time by using arrays).
* Update to include your email address if you want to get email alerts when the code is running/completed.
* Submit job from code directory: 
		* Example code: 

.. code-block:: bash
		
		cd /jukebox/norman/pygers/handbook/sample_project/code/preprocessing/

MRIQC
-----

MRIQC outputs an MRIQC group bold report and separate MRIQC reports for each subject/session. To have a quick look at the quality of the data acquired for your subjects, a good first start is to look at the group bold report to see if the `image quality metrics <https://mriqc.readthedocs.io/en/stable/measures.html>`_ shows any outlier subjects/sessions with respect to the quality of the data. When this is the case, you should check the subject/session-specific MRIQC to see if you can figure out what went wrong. It is recommended that you always check the framewise displacement and temporal SNR.  

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html