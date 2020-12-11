.. _designExp:

Designing your fMRI experiment
------------------------------

A full treatment of experimental design for fMRI research is beyond the scope of this handbook, but we try to provide a high-level summary with pointers to other resources; e.g. cite:`huettel2014functional`. Make sure to plan out your analyses prior to collecting data, as your planned analyses will ultimately constrain your design.

Most fMRI experiments fall into one of three categories: (1) `block or event-related tasks`_, (2) `resting-state`_, or (3) `naturalistic paradigms`_. You probably already have a general idea which kind of paradigm(s) you need, and many projects use multiple paradigms (e.g. collecting both task and resting-state runs). Each of these categories has some special considerations to keep in mind.

Block or event-related tasks
============================

Traditional task fMRI typically uses block or rapid event-related designs to measure differences in brain responses resulting from a particular experimental manipulation. These experiments typically contrast two or more stimuli or tasks that differ according to some variable of interest (e.g. images of different object categories), or parametrically vary some particular stimulus feature (e.g. visual orientation or eccentricity). Stimuli are either presented in extended blocks (block design), brief interleaved events (event-related design), or a mixture of both (mixed block/event-related design). These types of experiments typically rely on well-controlled stimuli and tasks, as well as well-specified specific timing and trial order.

**Special considerations for typical task designs:**

* Make sure to map out the full structure of your task: How many conditions are in your experiment? How many stimulus exemplars per condition? How many times does each stimulus, trial, or event occur per run? What is the duration of each trial or event? What is (average) latency between each event (i.e. inter-trial interval, ITI)? What is the duration of each run? How many runs are in your experiment? 

* What kind of behavioral responses will you collect (e.g. button-presses, verbal responses)? How will you analyze the behavioral responses (e.g. accuracy, reaction time)?  For more passive tasks, will you include catch trials to ensure the participant is paying attention? How many catch trials per run?

* Remember that the BOLD response typically peaks after ~5 seconds and does not return to baseline for 15+ seconds. Rapid event-related designs will result in overlapping hemodynamic responses for each event, although responses for each event can be partly disentangled using the GLM. Closer-spaced events result in more overlap, but may also allow for more densely sampling stimuli/conditions; i.e. a condition-rich design :cite:`kriegeskorte2008representational`.

* In most block and event-related designs, the experimenter hopes to neutralize any order effects. The typical solution is to use randomized trial order, but trial order can be more strictly counterbalanced using e.g. `T1I1 <https://cfn.upenn.edu/aguirre/wiki/public:t1i1_sequences>`_ or `de Bruijn <https://cfn.upenn.edu/aguirre/wiki/public:de_bruijn>`_ sequences :cite:`aguirre2007continuous` :cite:`aguirre2011bruijn`.

* Event-related designs typically use jittered (or stochastic) stimulus onset timing to ensure the participant isn't entrained to a fixed “rhythm” of onsets. Although jittering onsets by intervals of the TR may simplify analysis (referred to as “TR-locking”), this can result in artifacts, and using a continuous range of onsets is better. Typically interstimulus intervals are sampled (FreeSurfer's `optseq <https://surfer.nmr.mgh.harvard.edu/optseq/>`_, AFNI's `make_random_timing.py <https://afni.nimh.nih.gov/pub/dist/doc/program_help/make_random_timing.py.html>`_ and `@stim_analyze <https://afni.nimh.nih.gov/pub/dist/edu/data/CD.expanded/AFNI_data6/ht03/@stim_analyze>`_).

Resting-state
=============

In resting-state experiments, participants are not presented with any particular stimuli and are simply asked to keep still. Given the absence of an external stimulus or task, resting-state data are typically analyzed according to the covariation of intrinsic fluctuations among groups of voxels—i.e. functional connectivity and network analysis. The functional connectivity analyses used with resting-state data are especially sensitive to head motion and physiological noise, and therefore rely on more stringent noise mitigation; e.g. confound regression, scrubbing :cite:`power2014methods` :cite:`ciric2017benchmarking`.

**Special considerations for resting-state:**

* What is the duration of your resting-state scans? Note that longer scans (e.g. 10 minutes) yield more reliable connectivity estimates :cite:`birn2013effect`.

* What are your explicit “task” instructions? For example, will participants be instructed to keep their eyes open and maintain fixation? :cite:`patriat2013effect`.

* Will you use online motion monitoring (e.g. `FIRMM <https://nousimaging.com/>`_) during acquisition?

Naturalistic paradigms
======================

Rather than using tightly controlled task designs, some researchers use more naturalistic stimuli (e.g. movies, stories) in hopes of increasing the ecological validity of their findings. Naturalistic stimuli are difficult to exhaustively model and any given variable of interest is likely correlated with other variables. While traditional task data are typically designed to test a particular hypothesis, naturalistic data are typically rich enough to inform a variety of hypotheses.

**Special considerations for naturalistic paradigms:**

* Many naturalistic stimuli (e.g. movies) are quite long. How are you going to break up the stimuli? For example, you may wish to divide a 2-hour movie into eight ~15 minute segments.

* Naturalistic paradigms typically have lower statistical power to detect a specific effect than controlled experiments designed to isolate that effect :cite:`hamilton2020revolution`. Nonetheless, you should pick a naturalistic stimulus that includes variation along your variable(s) of interest.

References and resources
========================

.. bibliography:: ../refs.bib
  :style: apa
  :filter: docname in docnames

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-05-overview.html

