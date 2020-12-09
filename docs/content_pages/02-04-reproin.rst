.. _reproin:

Standardizing data acquisition with ReproIn
-------------------------------------------


ReproIn
^^^^^^^

Program cards should be set up according to the `ReproIn <http://reproin.repronim.org>`__ naming
convention. Formatting your program card according to ReproIn allows the
raw DICOM images to be automatically converted to BIDS-formatted NIfTI
images using HeuDiConv.

Minimal example
~~~~~~~~~~~~~~~

.. code-block:: bash

   $ tree

   └── NormaL/NormaL_McDevitt/mystudy
       └── mystudy
            └── anat_scout
            └── anat_T1w
            └── func_task-localizer_run-1
            └── func_task-localizer_run-2
            └── fmap_dir-AP
            └── fmap_dir-PA

Extended example
~~~~~~~~~~~~~~~~

.. code-block:: bash

   $ tree

   └── NormaL/NormaL_McDevitt/mystudy
       └── mystudy_ses-1
            └── anat_ses-1_scout
            └── anat_ses-1_T1w
            └── func_ses-1_task-localizer_run-1
            └── func_ses-1_task-localizer_run-2
            └── fmap_ses-1_dir-AP
            └── fmap_ses-1_dir-PA
       └── mystudy_ses-2
            └── anat_ses-2_scout
            └── anat_ses-2_T1w
            └── func_ses-2_task-localizer_run-1
            └── func_ses-2_task-localizer_run-2
            └── fmap_ses-2_dir-AP
            └── fmap_ses-2_dir-PA
       └── mystudy_ses-3
            └── anat_ses-3_scout
            └── anat_ses-3_T1w
            └── func_ses-3_task-localizer_run-1
            └── func_ses-3_task-localizer_run-2
            └── fmap_ses-3_dir-AP
            └── fmap_ses-3_dir-PA

Common mistakes
~~~~~~~~~~~~~~~

You should not have more than one scan with the exact same name (unless
you stop and re-run a scan and you want to delete the first instance of
that scan). When you have multiple scans with the exact same name,
HeuDiConv will automatically add the BIDS-noncompliant \_dup\_ flag to
the filename (indicating a duplicate run that can be deleted). In the
example above, it is important that if you have multiple runs of the
same task (func_ses-02_task-posttest) that you include \_run-1, \_run-2,
etc. in the name. Make sure not to switch underscores and hyphens;
underscores separate *entities* (e.g., key–value pairs like “task-study”
and “run-1”), where as hyphens separate the *suffix* and *extension* of
each key–value pair (e.g., “run” and “1”).

References
^^^^^^^^^^

Deichmann, R., Gottfried, J. A., Hutton, C., & Turner, R. (2003).
Optimized EPI for fMRI studies of the orbitofrontal cortex.
*NeuroImage*, *19*\ (2), 430-441.
https://doi.org/10.1016/S1053-8119(03)00073-9

Demetriou, L., Kowalczyk, O. S., Tyson, G., Bello, T., Newbould, R. D.,
& Wall, M. B. (2018). A comprehensive evaluation of increasing temporal
resolution with multiband-accelerated protocols and effects on
statistical outcome measures in fMRI. *NeuroImage*, *176*, 404–416.
https://doi.org/10.1016/j.neuroimage.2018.05.011

Gardumi, A., Ivanov, D., Hausfeld, L., Valente, G., Formisano, E., &
Uludağ, K. (2016). The effect of spatial resolution on decoding
accuracy in fMRI multivariate pattern analysis. *NeuroImage*, *132*,
32–42. https://doi.org/10.1016/j.neuroimage.2016.02.033

Sengupta, A., Yakupov, R., Speck, O., Pollmann, S., & Hanke, M. (2017).
The effect of acquisition resolution on orientation decoding from V1
BOLD fMRI at 7 T. *NeuroImage*, *148*,64–76.
https://doi.org/10.1016/j.neuroimage.2016.12.040

Mandelkow, H., de Zwart, J. A., & Duyn, J. H. (2017). Effects of
spatial fMRI resolution on the classification of naturalistic movies.
*NeuroImage*, *162*, 45–55.
https://doi.org/10.1016/j.neuroimage.2017.08.053

Weiskopf, N., Hutton, C., Josephs, O., Turner, R., & Deichmann, R.
(2007). Optimized EPI for fMRI studies of the orbitofrontal cortex:
compensation of susceptibility-induced gradients in the readout
direction. *Magnetic Resonance Materials in Physics, Biology and
Medicine*, *20*\ (1), 39. https://doi.org/10.1007/s10334-006-0067-6

Welvaert, M., & Rosseel, Y. (2013). On the definition of signal-to-noise
ratio and contrast-to-noise ratio for fMRI data. *PLOS ONE*, *8*\ (11),
e77089. https://doi.org/10.1371/journal.pone.0077089

Resources
^^^^^^^^^

practiCAL fMRI, “Comparing fMRI Protocols”
https://practicalfmri.blogspot.com/2011/01/comparing-fmri-protocols.html

The BIDS Specification
https://bids-specification.readthedocs.io/en/stable/02-common-principles.html

ReproIn walkthrough on Siemens Prisma console
https://github.com/ReproNim/reproin/blob/master/docs/walkthrough-1.md

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-07-overview.html



