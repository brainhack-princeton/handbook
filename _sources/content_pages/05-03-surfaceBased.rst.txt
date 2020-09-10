.. _surfaceBased:

======================
Surface-based analysis
======================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

This document will walk through 1st and 2nd level data analysis steps for surface data outputs from fMRIprep. The expected file format here is GIFTI (.gii). Due to compatibility limitations, the analyses described here will be performed largely in AFNI.

Preparing for running analyses
------------------------------

Before you run analyses on surface data in AFNI, you will need certain files prepared ahead of time. 3dDeconvolve, the command used for running a GLM, requires timing files for event related designs that denote when events occur during your run. Timing files will be in a .txt format and will consist of rows of numbers that tell when events occur in seconds from run start, where each row corresponds to each run of your scan session. You will need to create timing files for each subject and each condition you are including. 

Running a GLM
-------------

For our first level analysis we will use AFNIs 3dDeconvolve. Conveniently, 3dDeconvolve is largely format agnostic, so this first step can be applied as easily to volumetric data as surface data. For full documentation on how to use 3dDeconvolve, see here.

Here is an example of a call to 3dDeconvolve using an event related design:

.. code-block:: bash

		3dDeconvolve -polort A -jobs {how many CPU cores you want the job to run on} \
		  -input {a list of the image files that you wish to process} \
		  -local_times -num_stimts {how many events you have in your design} -stim_times 1 {text file containing the timing of each instance of event A in seconds, with a new line for each run} ‘GAM’ (this specifies that the program should fit a gamma function to your data, different functions are available) -stim_label 1 {Event Label A}\
		  -stim_times 2 {timing files in .txt format} ‘GAM’ -stim_label 2 {Event Label B}\
		  -gltsym 'SYM: {Event A} -{Event B}' -glt_label 1 {Event Label A}-{Event Label B} \ 
		  -ortvec {A matrix of noise variables that you want to regress out} \
		  -fout -tout \
		  -errts {save location for a file containing the residuals .gii} \ 
		  -bucket {save location for you GLM outputs .gii}

**Let’s go through some of these flags:**

* -input: Takes in your image files. Since we’re working on surfaces, these should all be .gii files. Don’t worry about concatenating runs ahead of time. 3dDeconvolve with do this for you. Format (omit quotes): “pathtofile/file.gii pathtofile/file2.gii pathtofile/file3.gii” 
* -local_times: This tells the program that you will be listing event times relative to the start of each run. You can also use “-global_times” which takes event times relative to the start of the first run, treating the data set as one long run, but this is not recommended (there tend to be compounding errors).
* -stim_times: Takes in a .txt or .1D file containing the timing of your event of interest, measured from the start of each run (if using -local_times). The event times should be separated by spaces, with a new line for each run.
* ‘GAM’: This sets what kind of hemodynamic response you’re expecting. A gamma function is usually appropriate for events that are shorter than one second. For longer events, you may wish to use ‘BLOCK’, which takes a duration input.
* -stim_label: This is just for convenience. GIve it a name that makes sense.
* -gltsym: Sets up contrasts. In the above example, we are setting up a simple contrast between event A and event B.
* -ortvec: A matrix of nuisance variables that you wish to regress out (e.g., movement). 
* -tout: Provides t values at each voxel, in addition to beta values. You probably want this!
* -errts: Provides model fit residuals. We’ll need this for smoothing.
* -bucket: Where to save your output file. Make sure to give it a sensible name, ending .gii or .gii.dset.

Viewing your data
-----------------

In order to view the outputs from 3dDeconvolve, you’ll need to use SUMA, which comes as part of the AFNI package. SUMA uses a lot of hotkeys, so you’ll want to refer to `this documentation <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/SUMA/Viewer.html>`_ to familiarize yourself with the controls.

Once everything is installed, just navigate to your data folder in the console and type ``suma -spec pathtosumafolder/SUMA/fsaverage6_both.spec &``. This opens Suma with the :blue:`spec` file that your data will overlay onto. Once the GUI has loaded, open the surface controller (ctrl + s). Click “Load Dset” and select your data. For further help, keep in mind that you can click :red:`BHelp` in the upper left corner then any button for more information on what that button does. Good luck!

Smoothing your data
-------------------

We will achieve smoothing by using the SurfSmooth function in AFNI. Rather than simply applying a blur to the raw data, SurfSmooth uses an iterative process to uniformly smooth your data up to a desired level of smoothness. Smoothing is based on the residual error outputs from the original GLM (errts), which is why we ran an unsmoothed GLM first.

Here is an example call to SurfSmooth:

.. code-block:: bash

		SurfSmooth - spec {path to the surface spec file that you want to use} \
		  -surf_A smoothwm \
		  -input {the raw data files that you want smoothed} \
		  -met HEAT_07 \
		  -target_fwhm {the degree of blur that you want to see in the output. 6 is common} \
		  -blurmaster {the errts output from running your first GLM} \
		  -Niter -1 \
		  -no_detrend_master \
		  -output {path and name for your output}

**Let’s go through some of those flags:**

* -met: THis tells SurfSmooth what smoothing method to use. As of publication (Nov. 2019) HEAT_07 is the most up to date.
* -blurmaster: the blurmaster is the dataset that is used to compute the applied smoothing. We use the residual errors from the first glm here because it avoids the need to sloppily detrend out anatomical smoothness.
* -Niter: How many iterations SurfSmooth has permission to perform. -1 gives permission to iterate until the target is reached. If the process is taking too long, supply a reasonable cap here, but be sure to check the outputs.

Run a GLM on your smoothed images
---------------------------------

Run 3dDeconvolve in precisely the same way as before, but this time give the smoothed images as your input.

Group Level Analysis
--------------------

This part is the same for surfaces and volumes. Which AFNI command you use will depend on your specific analysis of interest. Two straightforward options are:

* 3dttest++: `See documentation here <https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dttest++.html>`_. AFNI’s command for performing ttests on imaging data. 
* 3dANOVA2: See `documentation here <https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dttest++.html>`_. Performs a two-factor ANOVA. Usually one factor is your IV of interest and the other is subject as a random variable.

Regardless of what option you choose, make sure you output the results as a .gii file. This will store your stats on the same surfaces that we’ve been using up until now. 

Next, we’ll run multiple comparison corrected on these statistical maps to get our final output.

Determining Cluster Thresholds
------------------------------

Determining cluster thresholds is a multistep process… Step 1: use slow_surf_clustsim.py to generate a tcsh script. Step 2: Run the tcsh script, which runs the actual clustering simulation to determine your thresholds.

**Step 1:**

See documentation of slow_surf_clustsim.py `here <https://afni.nimh.nih.gov/pub/dist/doc/program_help/slow_surf_clustsim.py.html>`_. Here is an example script for surfaces:

.. code-block:: bash

		Slow_surf_clustsim.py -save_script {path to save location} \
		  -on_surface yes \
		  -uvar blur {the blur value for your images, ~6 if you used the above smoothing} \
		  -uvar spec_file {spec file for your surfaces} \
		  -uvar surf_vol {your output data file from the GLM} \
		  -uvar niter 1000

**Step 2:**

There should now be a tcsh script at the save location that you specified in step 1. Run that script: ``tcsh YourScriptName.tcsh``

We’re running a thousand simulations, so this will take a few minutes....

Using Cluster Thresholds
------------------------

After your simulation is complete, you will receive a recommendation to run a command like this:

.. code-block:: bash

		quick.alpha.vals.py -niter 1000 z.max.area.0.01

The alpha value (the last number in the above command) listed in the command refers to the uncorrected alpha threshold that you will apply to your data prior to setting the cluster area threshold. If you wish to use a different uncorrected threshold, simply enter the command above with your desired alpha instead to find clusters corresponding to that uncorrected threshold.

After you run quick.alpha.vals.py you will be given a list with two columns: cluster sizes and p-values. Simply select the corrected p-value that you are aiming for and, using SUMA, threshold your data to the associated minimum blob area:

* Load in your statistical map from the group-level analysis (.gii file)
* Using the slider, set SUMA to filter out any voxel under an uncorrected t-value of your choosing. Let’s say 0.01.
* Then, referencing the table that you got from quick.alpha.vals enter your desired minimum cluster size in the box under the “Area” label and click on the “Clst” button. 

If all has gone well, congratulations! These are your corrected results.

Put scripts here :blue:`/jukebox/pyger/handbook/sample_project/code/analysis` -- you can reference this path as you go but just explain they’re not connected to the given sample project (yet)

Resources
---------

Afni manual for 3dDeconvolve command: https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDeconvolve.html

Afni manual for Surfsmooth command: https://afni.nimh.nih.gov/pub/dist/doc/program_help/SurfSmooth.html

Afni manual for 3dttest++ command: https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dttest++.html

Afni manual for 3dAnova2 command: https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dANOVA2.html

Afni manual for slow_surf_clustsim.py script: https://afni.nimh.nih.gov/pub/dist/doc/program_help/slow_surf_clustsim.py.html

SUMA documentation: https://afni.nimh.nih.gov/pub/dist/doc/SUMA/suma/SUMA_do1.htm


.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 01-08-overview.html

