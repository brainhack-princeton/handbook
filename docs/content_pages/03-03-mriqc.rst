.. _mriqc:

==========================
Quality control with MRIQC
==========================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

To get an idea of the quality of your data, you can use the MRI Quality Check (MRIQC) BIDS app.

Running MRIQC
=============

The ``slurm_mriqc.sh`` script (which you can find in the :blue:`code/preprocessing/` directory) will run MRIQC on the cluster using the Slurm scheduler. It first computes metrics for all runs for an individual subject, followed by the group summary statistics. 

This script will use the following two scripts:

* ``run_mriqc.sh`` (this runs MRIQC at the subject level)
* ``run_mriqc_group.sh`` (this compiles group summary statistics)

*Running MRIQC for the first time*
----------------------------------

Because of a weird quirk in how MRIQC uses TemplateFlow, the first time each *user* runs MRIQC on the PNI server, MRIQC will need access to the internet to download some TemplateFlow files. The problem is that our compute nodes (i.e. the nodes used by Slurm) do not have access to the internet. However, the head node does. What this means is the first time each *individual user* runs MRIQC, you should run it on the head node, not using Slurm. After that, any subsequent time you run MRIQC (even if it is for a different project), you can use Slurm. 

In order to run on the head node: 

.. code-block:: bash

    # log into scotty
    ssh -XY username@scotty.pni.princeton.edu

    # navigate to your code/preprocessing directory
    cd /jukebox/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing/

    # open a tmux session
    tmux new -s mriqc

    # in your tmux window, run mriqc with subject ID (e.g. 001) as the input
    $ ./run_mriqc.sh 001

*Running MRIQC using Slurm*
---------------------------

After running on the head one time - and one time only per user! - you can run follow these instructions to run MRIQC using Slurm.

* Open slurm_mriqc.sh and update the array number to list the subjects you want to run through MRIQC. You can run multiple subjects in parallel by using arrays (e.g., #SBATCH --array=001,002,003,004).

* Update the #SBATCH --mail-user line to include your email address if you want to get email alerts when the job begins, ends, or fails.

.. TIP::
    Remember, in Slurm scripts, lines that start with ``#SBATCH`` are Slurm commands, not comments! All other lines that start with ``#`` are regular comments. 

*Submit your MRIQC job*
-----------------------

* Make sure you are in the directory where the slurm script lives (:blue:`code/preprocessing/`). Then use sbatch command to submit the job.

.. code-block:: bash
		
	# make sure you are in the code/preprocessing directory
	cd /jukebox/YOURLAB/USERNAME/YOURSTUDY/code/preprocessing/

	# submit the job
	sbatch slurm_mriqc.sh

MRIQC Outputs
=============
MRIQC outputs will live in :blue:`/data/bids/derivatives/mriqc/`

MRIQC outputs separate MRIQC reports for each individual run, as well as group reports. To have a quick look at the quality of the data acquired for your subjects, a good first start is to look at the group bold report to see if the `image quality metrics <https://mriqc.readthedocs.io/en/stable/measures.html>`_ show any outlier runs with respect to the quality of the data of your whole sample. When this is the case, you should check the individual run report to see if you can figure out what went wrong. You can simply click on the data point of interest on the group report, and it will automatically open the corresponding individual run report. It is recommended that you always check the framewise displacement and temporal SNR.  

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html