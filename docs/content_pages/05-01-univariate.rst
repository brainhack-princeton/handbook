.. _univariate:

============================================
Univariate regression and temporal filtering
============================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Using the confound matrix from fmriprep
---------------------------------------

*Which confounds to use?*

`FMRIprep outputs <https://fmriprep.readthedocs.io/en/stable/outputs.html#confounds>`_ a large confound matrix. You probably don’t want to use all of the confounds, but they give them to you so you can decide!

* Chris G’s  `official opinion here <https://neurostars.org/t/confounds-from-fmriprep-which-one-would-you-use-for-glm/326>`_ 

.. image:: ../images/chris_g_opinion.png
  :width: 700px
  :align: center
  :alt: Chris G's opinion

* `CompCor <https://doi.org/10.1016/j.neuroimage.2007.04.042>`_ is a separate software package [component-based noise correction] and has anatomical (aCompCor) and temporal (tCompCor) confound estimates
		* People would use aCompCor, and you should use all 6 components
		* Here’s the description from fmriprep of what comp cor is/what it’s doing:
				* *"A set of physiological noise regressors are extracted for the purpose of performing component-based noise correction (CompCor 10). Principal components are estimated after high-pass filtering the BOLD time-series (using a discrete cosine filter with 128s cut-off) for the two CompCor variants: temporal (tCompCor) and anatomical (aCompCor). Six tCompCor components are then calculated from the top 5% variable voxels within a mask covering the subcortical regions. This subcortical mask is obtained by heavily eroding the brain mask, which ensures it does not include cortical GM regions. For aCompCor, six components are calculated within the intersection of the aforementioned mask and the union of CSF and WM masks calculated in T1w space, after their projection to the native space of each functional run (using the inverse BOLD-to-T1w transformation)."*
		* I’m not sure if it matters that the data is filtered through a 128-s high-pass filter before deriving aCompCor components. I asked our fearless leader Chris G back in September 2018, but he never responded :’( Here’s my neurostars link though.
		* So the jury is still out on this one, but I’m not using aCompCor.







.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html
