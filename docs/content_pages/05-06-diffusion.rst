.. _diffusion:

Diffusion-weighted imaging
--------------------------

Diffusion-weighted MRI measures the diffusion of water molecules to capture microstructural properties of brain tissue (e.g. white matter tractography).

Scanning microstructural plasticity with dwMRI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Imaging plasticity in humans has long been restricted to macrostructural changes that take weeks or months to develop. Recent developments in neuroimaging have made it possible to assess rapid microstructural plasticity in the human brain :cite:`sagi2012learning`. Mean diffusivity, a marker of undirected diffusion strength, can reveal microstructural plasticity already hours after a learning experience :cite:`sagi2012learning` :cite:`brodt2018fast` :cite:`jacobacci2020rapid`, and the amount of learning-induced change in this marker of brain microstructure correlates with behavioral memory performance. Decreases in mean diffusivity reflect mechanisms of learning-dependent plasticity, such as astrocyte, myelin, or synaptic remodeling. Synapse density, BDNF expression, and astrocyte activation increase after learning at sites where mean diffusivity decreases, suggesting a tight link to experience induced structural plasticity :cite:`blumenfeld2011diffusion` :cite:`johansen2012human` :cite:`sagi2012learning`.

If you want to measure microstructural plasticity induced by your behavioral task, you have to take at least two scans of brain microstructure: one before and one after your behavioral intervention. Ideally, you should also have a no-learning control condition, where you measure your participant’s or a control group’s brain microstructure at the same temporal delays. 

Some things you need to be aware of before planning your experiment:
* Mean diffusivity fluctuates across the day; e.g. circadian and sleep-related effects :cite:`bernardi2016sleep`.
* Mean diffusivity differs globally between wakefulness and NREM sleep. The extracellular space widens in slow wave sleep, an effect associated with metabolite clearance.
* Effect sizes for changes in mean diffusivity are small. Percent signal change is estimated to lie between 0.5%-2%. Given greater variability, sample sizes need to be larger than in your regular fMRI experiment if you want to get a meaningful result (start planning at 30-40 participants per group).

You thus ideally want to measure all your participants at approximately the same time of day, or even better, at the same relative point of their circadian rhythm. You also will need to make sure that no one falls asleep during the diffusion scan. Ask your participants to keep their eyes open at all times and monitor their state of consciousness via an eye tracker.

Choosing your scanning acquisition parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The signal-to-noise ratio (SNR) of dwMRI sequences is generally lower than for traditional BOLD sequences. You thus 1) want your voxels larger and you 2) want to measure multiple repetitions of your images. 

* **Voxel size.** Going below 2 mm isotropic in voxel size may be risky. The larger your voxel size the better your signal estimates. Variability gets high with smaller voxels and meaningful signal drops. Having much larger voxels is equally tricky. Since diffusivity measures vary drastically in brain matter and the cerebrospinal fluid (CSF), you want to make sure to exclude voxels that may contain CSF. If you are interested in hippocampal plasticity, picking a voxel size larger than 2 mm isotropic will leave you little tissue to analyze after you excluded the boundary voxels that may still contain signal influenced by CSF.

* **Number of gradient directions.** Variability across participants and repeated measurements within one participant decreases when you measure more gradient directions (although we analyze the mean diffusion tensor). This effect asymptotes once you have sufficient measurement precision. 30 gradient directions (whole-sphere) seem sufficient for signal quality.

* **Number of shells and b0 images.** To assess changes in mean diffusivity, you only have to measure one shell. A commonly used b-value for this is 1000 s/mm2. It makes sense to acquire multiple b0 images interspersed throughout your image acquisition.

* **Repetition number and encoding directions.** Since SNR is low, you need to collect repeated diffusion scans, in both A-P and P-A encoding directions. Six repetitions (A-P, P-A, A-P, P-A, A-P, P-A) may be a good SNR-time tradeoff (one repetition takes approx. 2 min to acquire).

You can acquire diffusion weighted images using multi-band sequences provided by the University of Minnesota Center for Magnetic Resonance Research. Following the recommendations listed above, you may want to measure six acquisitions of a monopolar sequence (cmrr_mbep2d_diff, 3000ms TR; 53ms TE; 90° FA; b=1000s/mm2; 30 whole-sphere gradient directions; 6 interspersed b0 images; 220mm FOV; 110 voxel matrix size; 2mm isotropic voxel size; 70 transversal slices with interleaved slice acquisition; PAT 2 (GRAPPA); MB 2). Using alternating anterior-to-posterior and posterior-to-anterior phase encoding direction for these acquisitions will allow you to use FSL’s distortion correction tools during later processing.

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

