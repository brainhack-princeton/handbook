.. _openNeuro:

Why and how to use this handbook
--------------------------------

What is open neuroimaging? Neuroimaging research is notoriously plagued by flexible analysis pipelines [Carp2012]_, insufficient or opaque reporting [Nichols2018]_, and low statistical power [Button2013]_ [Turner2018]_. These pathologies undermine the reliability of our collective findings, and make transparency and reproducibility all the more important [Poldrack2017]_. Broadly, the aim of open neuroimaging is to adopt better practices to counteract these problems and allow ourselves greater confidence in our work.

The primary goal of this handbook is to promote practices for improving the transparency and reproducibility of neuroimaging research. For example, we promote data management standards that facilitate data sharing and re-use, which has tremendous humanitarian and financial benefits [Milham2018]_; we promote practices like software containerization that allow others to more easily re-run your analyses [Ghosh2017]_. The handbook doesn't touch on many aspects of open neuroimaging, but we point to other resources for a more complete picture; e.g., the `ReproNim <https://www.repronim.org/>`_ training course [Kennedy2019]_.

.. admonition:: Quote

    "My definition of open science is probably not the same as yours. And that's okay." ---Kirstie Whitaker [Whitaker2019]_

The term "open science" means different things to different people: for example, open source software, data sharing, open access publishing, accessible educational resources, diversity, inclusivity, equitable power structures, and so on [Whitaker2019]_. Some practices can be particularly challenging for early career researchers (ECRs) [Allen2019]_ [Poldrack2019]_; ECRs are often incentivized to get results as quickly as possible, and senior scientists sometimes do not appreciate the benefits of open science practices. Luckily, open science is not all-or-nothing. You shouldn't feel pressured to adopt "all" open science practices at once. Adopt whatever practices seem most useful and accessible, and integrate them into your workflow. Every little bit helps.

.. tip:: Make open science work for **you**. Incorporating best practices into your everday workflow is the best way to learn.

Open science practices are not just ideals, but will have practical, concrete benefits for you, your colleagues, and the field. For example, you may need to revisit a dataset or analysis after a month or a year. Taking the time to make you workflow as transparent and reproducible as possible *now* will save you a lot of time down the road. Future-proof your workflow by adopting best practices from the start and making your analysis open "by design" [Halchenko2015]_. Your future self will thank you.

Navigating this handbook
~~~~~~~~~~~~~~~~~~~~~~~~

We recommend working through the handbook step by step from the beginning. You can treat the handbook like an interactive textbook and after each section proceed directly to the next topic using the navigation menu at the left. However, if you’re in the middle of an analysis or just need a refresher on a particular topic, you can skip ahead. In addition to the :ref:`landing page <index>`, our :ref:`flowchart <overview>` provides a high-altitude visual overview of fMRI analysis and can be used to navigate the handbook. Many questions in fMRI don't have a single "right" answer, so we've compiled answers to a variety of common questions from the Princeton neuroimaging community in our crowdsourced :ref:`FAQ <faq>`; this is a great place to start if you have questions about acquisition parameters, experimental design, etc — and want to get the gist of how researchers approach these problems. If you're confused about terminology, try the :ref:`glossary <glossary>`; if you're looking for something specific, try the `search <../search.html>`_ function. At the end of each page, we provide references and links to relevant external resources.

.. admonition:: Software installation

    The analysis workflows in this handbook rely on several different software packages. Two major fMRI analysis packages used throughout the handbook are `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki>`_ and `AFNI <https://afni.nimh.nih.gov/>`_, although containerized software packages such as `fMRIPrep <https://fmriprep.readthedocs.io/en/stable/>`_ and `MRIQC <https://mriqc.readthedocs.io/>`_ also play a central role. Containerized packages like fMRIPrep use FSL and AFNI under the hood (as well as other software like `ANTs <http://stnava.github.io/ANTs/>`_, `nilearn <https://nilearn.github.io/>`_, and `FreeSurfer <https://surfer.nmr.mgh.harvard.edu/>`_), but are shipped with all of their dependencies included and **do not** require you to separately install these packages. Although you do not need to install these software packages now, you may opt to install them later for visualization or downstream analysis. Each of these software packages has a somewhat different design philosophy and user interface. FSL and AFNI each have their respective installation procedures (`FSL installation <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation>`_, `AFNI installation <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/index.html>`_) or can be installed using `NeuroDebian <http://neuro.debian.net/>`_. We also recommend familiarizing yourself with `Python <https://www.python.org/>`_ for particular downstream analyses, which is most easily installed using `Anaconda <https://www.anaconda.com/distribution/>`_ (or `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_).

References and resources
^^^^^^^^^^^^^^^^^^^^^^^^^

.. |nbsp| unicode:: 0xA0
   :trim:

.. [Allen2019] |nbsp| Allen, C., & Mehler, D. M. (2019). Open Science challenges, benefits and tips in early career and beyond. *PLoS Biology*, *17*\(5), e3000246. https://doi.org/10.1371/journal.pbio.3000246

.. [Button2013] |nbsp| Button, K. S., Ioannidis, J. P., Mokrysz, C., Nosek, B. A., Flint, J., Robinson, E. S., & Munafò, M. R. (2013). Power failure: why small sample size undermines the reliability of neuroscience. *Nature Reviews Neuroscience*, *14*\(5), 365–376. https://doi.org/10.1038/nrn3475

.. [Carp2012] |nbsp| Carp, J. (2012). The secret lives of experiments: methods reporting in the fMRI literature. *NeuroImage*, *63*\(1), 289-300. https://doi.org/10.1016/j.neuroimage.2012.07.004

.. [Ghosh2017] |nbsp| Ghosh, S. S., Poline, J. B., Keator, D. B., Halchenko, Y. O., Thomas, A. G., Kessler, D. A., & Kennedy, D. N. (2017). A very simple, re-executable neuroimaging publication. *F1000Research*, 6. https://dx.doi.org/10.12688%2Ff1000research.10783.2

.. [Halchenko2015] Halchenko, Y. O., & Hanke, M. (2015). Four aspects to make science open "by design" and not as an after-thought. *GigaScience*, *4*\(1), 31. https://doi.org/10.1186/s13742-015-0072-7

.. [Kennedy2019] Kennedy, D. N., Abraham, S. A., Bates, J. F., Ghosh, S. S., Gillespie, T. H., Goncalves, M., ... & Hodge, S. M. (2019). Everything matters: the ReproNim perspective on reproducible neuroimaging. *Frontiers in Neuroinformatics*, *13*, 1. https://doi.org/10.3389/fninf.2019.00001

.. [Milham2018] |nbsp| Milham, M. P., Craddock, R. C., Son, J. J., Fleischmann, M., Clucas, J., Xu, H., Koo, B., Krishnakumar, A., Biswal, B. B., Castellanos, F. X., Colcombe, S., Di Martino, A., Zuo, X.-N., & Klein, A. (2018). Assessment of the impact of shared brain imaging data on the scientific literature. *Nature Communications*, 9. https://doi.org/10.1038/s41467-018-04976-1

.. [Nichols2018] |nbsp| Nichols, T. E., Das, S., Eickhoff, S. B., Evans, A. C., Glatard, T., Hanke, M., Kriegeskorte, N., Milham, M. P., Poldrack, R. A., Poline, J.-B., Proal, E., Thirion, B., Van Essen, D. C., White, T., & Yeo, B. T. T. (2017). Best practices in data analysis and sharing in neuroimaging using MRI. *Nature Neuroscience*, *20*\(3), 299–303. https://doi.org/10.1038/nn.4500

.. [Poldrack2017] |nbsp| Poldrack, R. A., Baker, C. I., Durnez, J., Gorgolewski, K. J., Matthews, P. M., Munafò, M. R., Nichols, T. E., Poline, J.-B., Vul, E., & Yarkoni, T. (2017). Scanning the horizon: towards transparent and reproducible neuroimaging research. *Nature Reviews Neuroscience*, *18*\(2), 115–126. https://doi.org/10.1038/nrn.2016.167

.. [Poldrack2019] |nbsp| Poldrack, R. A. (2019). The costs of reproducibility. *Neuron*, *101*\(1), 11-14. https://doi.org/10.1016/j.neuron.2018.11.030

.. [Turner2018] |nbsp| Turner, B. O., Paul, E. J., Miller, M. B., & Barbey, A. K. (2018). Small sample sizes reduce the replicability of task-based fMRI studies. *Communications Biology*, *1*, 62. https://doi.org/10.1038/s42003-018-0073-z

.. [Whitaker2019] |nbsp| Whitaker, K. (2019, June). *Diversity and inclusion as core values of open science.* Presented at the meeting of the Organization for Human Brain Mapping, Rome, Italy. https://doi.org/10.5281/zenodo.3243216

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-08-overview.html




