.. _whatIsBIDS:

What is BIDS (Brain Imaging Data Structure)?
--------------------------------------------

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Many of the best practices we encourage in this handbook revolve around the Brain Imaging Data Structure (BIDS) :cite:`gorgolewski2016brain`. Neuroimaging research relies on complex multimodal data and different software packages have historically used different naming and organization conventions. Different labs and different researchers use idiosyncratic conventions---even the same researcher may use different conventions from experiment to experiment. The goal of `BIDS <https://bids-specification.readthedocs.io/en/stable/>`_ is to create an easy-to-adopt community standard for organizing neuroimaging data. BIDS facilitates: `check`<:ref:`openNeuro`>_

* **Data validation:** Data often has "bugs"---just like software. The `BIDS-Validator <https://github.com/bids-standard/bids-validator>`_ can be used to check the integrity of your BIDS dataset, allowing you to identify potential errors or inconsistencies in the data structure.

* **Collaboration:** By using a standard format, working on data collaboratively within and across labs becomes much easier (no more re-organizing someone else's data). It also makes it much easier to return to the same dataset years later (your future self will thank you).

* **Data analysis:** The machine-readable format and rich metadata of BIDS allows software packages---such as `fMRIPrep <https://fmriprep.readthedocs.io/>`_ and `MRIQC <https://mriqc.readthedocs.io/en/stable/>`_---to process BIDS data in an automated fashion. There is a growing number of software packages---called `BIDS Apps <https://bids-apps.neuroimaging.io/>`_---that capitalize on BIDS :cite:`gorgolewski2017bids`.

* **Sharing data:** Data sharing is an important element of reproducible science and is encouraged (often enforced!) by many major federal funding agencies (e.g., `NIH <https://grants.nih.gov/grants/policy/data_sharing/>`_, `NSF <https://www.nsf.gov/bfa/dias/policy/dmp.jsp>`_, `ERC <https://erc.europa.eu/managing-project/open-access>`_). BIDS allows others to more easily use your data and is the standard used by the `OpenNeuro <https://openneuro.org/>`_ data sharing platform :cite:`poldrack2017openfmri`. The workflow in this handbook encourages converting your data to BIDS format as early in the workflow as poosssible to facilitate reproducibility and save you the energy of retroactivately organizing your data at the time of sharing. 

Consult the `BIDS Specification <https://bids-specification.readthedocs.io/en/stable/>`_ for detailed documentation on formatting. If you want to setup a new study using BIDS, check out our documentation and scripts for :ref:`converting raw data to BIDS format<converting>`; or, you can :ref:`practice using BIDS with our sample dataset<sampleProjectWithBIDS>`!

Resources
^^^^^^^^^

* `BIDS Specification <https://bids-specification.readthedocs.io/en/stable/>`_

* `BIDS-Validator <https://github.com/bids-standard/bids-validator>`_

* `BIDS Apps <https://bids-apps.neuroimaging.io/>`_

* `OpenNeuro <https://openneuro.org/>`_

* `National Institutes of Health (NIH) Data Sharing Policy <https://grants.nih.gov/grants/policy/data_sharing/>`_

* `National Science Foundation (NSF) Dissemination and Sharing of Research Results <https://grants.nih.gov/grants/policy/data_sharing/>`_

* `European Research Council (ERC) Open Access <https://erc.europa.eu/managing-project/open-access>`_

References
^^^^^^^^^^

.. bibliography:: ../refs.bib
  :style: apa
  :filter: docname in docnames

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html
