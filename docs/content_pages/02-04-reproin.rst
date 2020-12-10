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


Resources
^^^^^^^^^

The BIDS Specification
https://bids-specification.readthedocs.io/en/stable/02-common-principles.html

ReproIn walkthrough on Siemens Prisma console
https://github.com/ReproNim/reproin/blob/master/docs/walkthrough-1.md

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html



