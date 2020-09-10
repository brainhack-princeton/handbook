.. _visualization:

======================
Visualization software
======================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Introduction
------------

For a lot of reasons, you’ll want to visualize your outputs from initial data collection, registration, preprocessing, and your final analyses! For all of these, make sure you log into the remote server with:

.. code-block:: bash

		ssh username@sever -XY

The -XY enables X11 forwarding for new windows to be able to open on your local computer. (-X setting is with security controls and -Y is without security--see “type man ssh” in terminal for more information.) Also, make sure to have XQuartz installed on your local computer. (Note - some versions of XQuartz may not be compatible with the particular software you want to use.)

FSL
---

VIsualizing data in FSL used to be with fslview, but with the newer versions of FSL, this has now become fslview_deprecated. FSL now uses the viewer fsleyes. The drawback of fslview is that it only allows you to open images if they have the **exact same** dimensions (meaning grid size & resolution). Fsleyes fixed that issue so you can open multiple nifti files at once.

To open either, make sure you have the FSL module loaded. Then you would type:

.. code-block:: bash

		fslview_deprecated &

OR

.. code-block:: bash

		fsleyes &

This will just open the visualizer. The “&” at the end allows you to run other commands in terminal while the X window is open. Otherwise, you will need to close out of the X window to be able to run another command.

You can open a specific nifti image at the same time by just putting it at the end:

.. code-block:: bash

		fsleyes anat.ii.gz

Other tools: You can use fslview/fsleyes to load standard MNI templates (with open-->standard) and atlases (with tools-->) to get ROIs from the atlase like Harvard-Oxford.

AFNI
----

The AFNI viewer can do a lot, but it can be overwhelming for this reason. For the AFNI viewer, you just have to type:

.. code-block:: bash

		afni 

Into your terminal window. This one is meant to have an “underlay” image and “overlay” image. The underlay is the standardized image that you would want to display your results on top of. For example, the mni-icbm-2009c standard. The overlay would be the results. 

You would then choose which “BRIK” you want to display. This part really only makes sense if you did your GLM analysis with AFNI. It saves each coefficient as a separate BRIK in a nifti file. The BRIKS (unless saved separately in another step) are only accessible via AFNI software. So you can select which statistic you want to visualize. Then you select which statistic you want to use in terms of thresholding for visualization. 

To then run cluster correction in the viewer, threshold the data by right-clicking for p-values and enter the p-value you want to threshold for each voxel. Then go up to “clusterize” and enter NN and minimum voxel size in the cluster settings (which you got from an output after running Clustsim).

Then, click rpt for the report to see if there are any significant clusters that meet the voxel and cluster criteria. From there, you can do other cool things like go to each cluster, save the cluster, and with “whereami” get some labels for the cluster!

PYSURFER
--------

*From Rolando:*

Below are the two scripts to get pysurfer up (jupyter notebook and a .py).

https://github.com/rmasiso/helpful/tree/master/fmri

NOTE: Don't forget, pysurfer works with python 2.7, so make sure to 'source activate' your environment! 




.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-07-overview.html

