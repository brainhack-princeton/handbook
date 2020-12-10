.. _openNeuro:

Why and how to use this handbook
--------------------------------

What is open neuroimaging? Neuroimaging research is notoriously plagued by flexible analysis pipelines :cite:`carp2012secret`, insufficient or opaque reporting :cite:`nichols2017best`, and low statistical power :cite:`button2013power` :cite:`turner2018small`. These pathologies undermine the reliability of our collective findings, and make transparency and reproducibility all the more important :cite:`poldrack2017scanning`. Broadly, the aim of open neuroimaging is to adopt better practices to counteract these problems and allow ourselves greater confidence in our work.

The primary goal of this handbook is to promote practices for improving the transparency and reproducibility of neuroimaging research. For example, we promote data management standards that facilitate data sharing and re-use, which has tremendous humanitarian and financial benefits :cite:`milham2018assessment`; we promote practices like software containerization that allow others to more easily re-run your analyses :cite:`ghosh2017very`. The handbook doesn't touch on many aspects of open neuroimaging, but we point to other resources for a more complete picture; e.g., the `ReproNim <https://www.repronim.org/>`_ training course :cite:`kennedy2019everything`.

.. admonition:: Quote

    "My definition of open science is probably not the same as yours. And that's okay." ---Kirstie Whitaker :cite:`whitaker_kirstie_2019_3243217`

The term "open science" means different things to different people: for example, open source software, data sharing, open access publishing, accessible educational resources, diversity, inclusivity, equitable power structures, and so on :cite:`whitaker_kirstie_2019_3243217`. Some practices can be particularly challenging for early career researchers (ECRs) :cite:`allen2019open` :cite:`poldrack2019costs`; ECRs are often incentivized to get results as quickly as possible, and senior scientists sometimes do not appreciate the benefits of open science practices. Luckily, open science is not all-or-nothing. You shouldn't feel pressured to adopt "all" open science practices at once. Adopt whatever practices seem most useful and accessible, and integrate them into your workflow. Every little bit helps.

.. tip:: Make open science work for **you**. Incorporating best practices into your everday workflow is the best way to learn.

Open science practices are not just ideals, but will have practical, concrete benefits for you, your colleagues, and the field. For example, you may need to revisit a dataset or analysis after a month or a year. Taking the time to make you workflow as transparent and reproducible as possible *now* will save you a lot of time down the road. Future-proof your workflow by adopting best practices from the start and making your analysis open "by design" :cite:`halchenko2015four`. Your future self will thank you.

Navigating this handbook
~~~~~~~~~~~~~~~~~~~~~~~~

We recommend working through the handbook step by step from the beginning. You can treat the handbook like an interactive textbook and after each section proceed directly to the next topic using the navigation menu at the left. However, if you’re in the middle of an analysis or just need a refresher on a particular topic, you can skip ahead. In addition to the :ref:`landing page <index>`, our :ref:`flowchart <overview>` provides a high-altitude visual overview of fMRI analysis and can be used to navigate the handbook. Many questions in fMRI don't have a single "right" answer, so we've compiled answers to a variety of common questions from the Princeton neuroimaging community in our crowdsourced :ref:`FAQ <faq>`; this is a great place to start if you have questions about acquisition parameters, experimental design, etc — and want to get the gist of how researchers approach these problems. If you're confused about terminology, try the :ref:`glossary <glossary>`; if you're looking for something specific, try the `search <../search.html>`_ function. At the end of each page, we provide references and links to relevant external resources.

.. admonition:: Software installation

    The analysis workflows in this handbook rely on several different software packages. Two major fMRI analysis packages used throughout the handbook are `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki>`_ and `AFNI <https://afni.nimh.nih.gov/>`_, although containerized software packages such as `fMRIPrep <https://fmriprep.readthedocs.io/en/stable/>`_ and `MRIQC <https://mriqc.readthedocs.io/>`_ also play a central role. Containerized packages like fMRIPrep use FSL and AFNI under the hood (as well as other software like `ANTs <http://stnava.github.io/ANTs/>`_, `nilearn <https://nilearn.github.io/>`_, and `FreeSurfer <https://surfer.nmr.mgh.harvard.edu/>`_), but are shipped with all of their dependencies included and **do not** require you to separately install these packages. Although you do not need to install these software packages now, you may opt to install them later for visualization or downstream analysis. Each of these software packages has a somewhat different design philosophy and user interface. FSL and AFNI each have their respective installation procedures (`FSL installation <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation>`_, `AFNI installation <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/index.html>`_) or can be installed using `NeuroDebian <http://neuro.debian.net/>`_. We also recommend familiarizing yourself with `Python <https://www.python.org/>`_ for particular downstream analyses, which is most easily installed using `Anaconda <https://www.anaconda.com/distribution/>`_ (or `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_).

References and resources
^^^^^^^^^^^^^^^^^^^^^^^^^

.. bibliography:: ../refs.bib
  :style: apa
  :filter: docname in docnames

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html




