.. _reproin:

Standardizing data acquisition with ReproIn
-------------------------------------------

Typical fMRI acquisitions include several types of images, including
functional images, anatomical images, and field map images. In the
following, we provide some recommendations about acquisition parameters,
as well as naming conventions intended to facilitate data sharing.

Functional images
^^^^^^^^^^^^^^^^^

When setting up the sequence for a functional scan, there are several
factors to take into consideration, including spatial resolution (voxel
size in mm), temporal resolution (repetition time; TR), echo time (TE),
number of slices (coverage), in-plane acceleration, multiband
acceleration, flip angle, pixel bandwidth, and partial Fourier
reconstruction. Most sequences require a compromise between these
factors; not all combinations are feasible.

There are varying opinions on acquisition parameters, but we can make
some very general recommendations. Consult the FAQ for additional
details.

*Spatial resolution:* While larger voxels yield poorer spatial
localization, reducing voxel size also reduces signal-to-noise ratio
(SNR). On the other hand, smaller voxels may reduce susceptibility due
to lower partial volume effects. Voxel sizes between 2 and 3 mm are
typical for whole-brain functional imaging at 3T. However, smaller
voxels (e.g., 1.5 mm) may be beneficial for applications requiring
fine-grained spatial localization (e.g., hippocampal subfields).

*Temporal resolution:* Reducing the duration of the TR yields more
samples and thus increases SNR (although this is ultimately limited by
the smoothness of the hemodynamic signal). Typical TRs are 1.5 or 2.0 s,
although shorter TRs are becoming more common.

*Echo time:* Shorter TE (e.g., < 30 ms) may be beneficial for
experiments targeting brain areas susceptible to signal dropout (e.g.,
orbitofrontal cortex, medial temporal lobe). Typical TE ranges from
28–36 ms, and may be reduced by increasing pixel bandwidth.

*Number of slices:* The product of the voxel size (i.e., slice
thickness) and number of slices determines the brain coverage; we
recommend 120 mm to achieve whole-brain coverage on most subjects. When
using multiband (SMS) acceleration, the number of slices must be a
multiple of the multiband factor.

*In-plane acceleration:* The two main types of in-plane acceleration
reduce acquisition time by acquiring within-slice data in parallel in
either image space (mSENSE) or *k*-space (GRAPPA). GRAPPA may be used in
conjunction with multislice acceleration, but may increase
susceptibility to head motion and other artifacts.

*Multiband acceleration:* Multiband or simultaneous multislice (SMS)
imaging reduces acquisition time by acquiring multiple slices
simultaneously; for example, SMS 4 will acquire four slices
simultaneously. Large multiband acceleration factors can increase
artifacts; we recommend using SMS 2–4.

*Flip angle:* Flip angle should be optimized to the Ernst angle
(http://www.mritoolbox.com/ErnstAngle.html) based on the TR and a T1
recovery rate of ~1500 ms
(http://www.mritoolbox.com/ParameterDatabase.html).

*Bandwidth:* We recommend using a pixel bandwidth 1500–2500 Hz; higher
bandwidth results in poorer spatial specificity.

*Partial Fourier reconstruction:* Subsampling *k*-space during
reconstruction can accelerate acquisition, but may reduce spatial
specificity.

Reference sequences
~~~~~~~~~~~~~~~~~~~

For Siemens Skyra and Prisma, PNI provides several reference sequences:

Skyra
*****

.. code-block:: none

   3.0 mm voxels, TR = 1.5, TE = 30, SMS = 2, 42 slices (126 mm)
   2.5 mm voxels, TR = 2.0, TE = 30, SMS = 2, 50 slices (125 mm)
   2.5 mm voxels, TR = 1.5, TE = 30, SMS = 3, 51 slices (127.5 mm)
   2.5 mm voxels, TR = 1.0, TE = 30, SMS = 4, 44 slices (110 mm)
   2.0 mm voxels, TR = 1.5, TE = 30, SMS = 3, PF = 6/8, 51 slices (102 mm)
   2.0 mm voxels, TR = 1.0, TE = 30, SMS = 5, PF = 6/8, 55 slices (110 mm)
   1.5 mm voxels, TR = 2.0, TE = 41, SMS = 5, PF = 6/8, 75 slices (112.5 mm)

Prisma
******

.. code-block:: none

   3.0 mm voxels, TR = 1.5, TE = 30, SMS = 2, 42 slices (126 mm)
   2.5 mm voxels, TR = 2.0, TE = 30, SMS = 2, 54 slices (135 mm)
   2.5 mm voxels, TR = 1.5, TE = 30, SMS = 3, 63 slices (157.4 mm)
   2.5 mm voxels, TR = 1.0, TE = 30, SMS = 4, 52 slices (130 mm)
   2.0 mm voxels, TR = 1.5, TE = 30, SMS = 3, PF = 7/8, 57 slices (114 mm)
   2.0 mm voxels, TR = 1.0, TE = 30, SMS = 4, PF = 7/8, 52 slices (104 mm)
   1.5 mm voxels, TR = 2.0, TE = 30, SMS = 4, PF = 6/8, 84 slices (126 mm)

Anatomical images
^^^^^^^^^^^^^^^^^

Typical fMRI analyses require a T1-weighted structural image for spatial
alignment. We use FreeSurfer’s recommended multi-echo sequence with 1 mm
isotropic voxels with a GRAPPA acceleration factor of 2 (~6 minute
duration; `FreeSurfer Protocol <https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki?action=AttachFile&do=get&target=FreeSurfer_Suggested_Morphometry_Protocols.pdf>`_.
You may also collect a T2-weighted structural image, which can provide
better contrast for differentiating subcortical structures (~5 minute
duration). Other analysis pipelines may require specific structural
images. For example, if you want to use the ASHS toolbox for automatic
segmentation of hippocampal subfields, or even if you want to do manual
segmentations of hippocampal subfields, you will need an oblique coronal
T2-weighted turbo spin echo (TSE) acquisition with high in-plane
resolution (0.4 mm).

Field map images
^^^^^^^^^^^^^^^^

Functional images are distorted by magnetic field inhomogeneities near
the sinuses. Field map images can be used to recover displaced signal, a
process called susceptibility distortion correction (SDC). There are
several methods of SDC (which rely on different types of field map
acquisitions):

*Phase encoding polarity (PEPOLAR) correction:* This method uses two
spin echo acquisitions with opposite phase encoding directions
(anterior-to-posterior and posterior-to-anterior; also known as
blip-up/blip-down).

*Phase-difference B0 correction:* This method uses the difference in
phase between two echoes in single acquisition (double- or dual-echo
field map).

*Fieldmap-less correction:* This method uses nonlinear registration to
perform SDC based on an average field map atlas (and does not require a
field map acquisition).

ReproIn
^^^^^^^

Program cards should be set up according to the ReproIn naming
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

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html



