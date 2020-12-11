.. _funcConn:

================================
Functional connectivity analyses
================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

We have examined `evoked BOLD responses <https://brainhack-princeton.github.io/handbook/content_pages/05-01-univariate.html>`_ and `spatial patterns of activity <https://brainhack-princeton.github.io/handbook/content_pages/05-02-mvpa.html>`_, but sometimes information can be represented more globally at a network level. One measure of interactions between brain areas that are physically distant is functional connectivity. Functional connectivity is usually measured by a Pearson correlation between the BOLD time courses extracted from two distinct areas in the brain. In this section, we will demonstrate basic steps for functional connectivity analyses by using the ‘story’ task data from the sample dataset. 

This section is developed based on the Intro to Functional Connectivity workbook designed by Michael Arcaro as part of NEU502. 


Confound regression
--------------------

Confound regression is crucial for functional connectivity analyses because connectivity measures are affected by artifacts that systematically shape BOLD timeseries, such as head motion, scanner-induced artifacts, respiratory artifacts, etc. Unfortunately, there is no gold standard for confound regression (i.e. which variables to regress out, whether to use scrubbing), but there is much information about pros and cons of different pipelines [e.g., Parkes et al. 2018, Ciric et al. 2017].

Here, we demonstrate one procedure to perform confound regression (also see this page). We assume you have followed the instructions for fMRIPrep and preprocessed the data already. Let’s take the preprocessed data (i.e., fMRIPrep-ed data). For each run, extract regressor columns from the confounds_regressors.tsv file. You can regress out CSF, WM, global signal, and motion (e.g., 6-, 12-, 24-parameter), aCompCor components, and/or AROMA outputs. 

Preprocessed BOLD data (in MNI space) and confound regressors for each run: 
.. code-block:: bash

		func_file=BIDS_DIR/derivatives/fmriprep/sub-001/ses-01/func/sub-001_ses-01_task-story_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz
		confound_file=BIDS_DIR/derivatives/fmriprep/sub-001/ses-01/func/sub-001_ses-01_task-story_run-1_desc-confounds_regressors.tsv


Extract confound regressor columns and save to a 1D file, using AFNI’s 1dcat:
.. code-block:: bash

		module load afni
		1dcat $confound_file'[HEADER1, HEADER2,...]' > confounds_ortvec_run-1.1D

The following code performs confound regression, spatial/temporal smoothing, and censoring in a single step, using AFNI’s 3dTproject. Here, we demonstrate how to include polynomial orthogonalization (-polort 2), confound regressors (-ort FILENAME), spatial smoothing with a 4mm kernel (-blur 4), bandpass filtering (-bandpass 0.01 0.1), and censoring (-censor and -cenmode). Feel free to include a subset of these options.
.. code-block:: bash

		3dTproject \
		-polort 2 \
		-input $func_file \
		-ort confounds_ortvec_run-1.1D \
		-blur 4 \
		-bandpass 0.01 0.1 \ 
		-censor CENSOR_FILE -cenmode ZERO \
		-prefix OUTPUT_FILENAME

Here’s a sample script to repeat the steps above for all four runs and concatenate them. This script filters out CSF, WM, global signal, and 24-parameter motion and does not perform any temporal/spatial smoothing or censoring. 
.. code-block:: bash

		#! /bin/bash

		module load afni

		PROJECT_DIR=/jukebox/YOURLAB/USERNAME/sample_project
		BIDS_DIR=$PROJECT_DIR/data/bids

		# set paths to your directories
		func_dir=$BIDS_DIR/derivatives/fmriprep/sub-001/ses-01/func
		out_dir=[your output directory]

		# confound regression
		for runidx in 1 2 3 4
		do
			# for each run, extract columns of interest from the confounds file
			confoundfile=$func_dir/sub-001_ses-01_task-story_run-0${runidx}_desc-confounds_regressors.tsv
			1dcat $confoundfile'[csf,white_matter,global_signal,trans_x,trans_x_derivative1,trans_x_derivative1_power2,trans_x_power2,trans_y,trans_y_derivative1,trans_y_derivative1_power2,trans_y_power2,trans_z,trans_z_derivative1,trans_z_derivative1_power2,trans_z_power2,rot_x,rot_x_derivative1,rot_x_derivative1_power2,rot_x_power2,rot_y,rot_y_derivative1,rot_y_power2,rot_y_derivative1_power2,rot_z,rot_z_derivative1,rot_z_derivative1_power2,rot_z_power2]' > $out_dir/confounds_ortvec_run-0${runidx}.1D

			#  regress out and save the 'denoised' file into the output directory
			3dTproject -polort 2 -input $func_dir/sub-001_ses-01_task-story_run-0${runidx}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz        \
			           -ort $out_dir/confounds_ortvec_run-0${runidx}.1D \
			           -prefix $out_dir/sub-001_ses-01_task-story_run-0${runidx}_space-MNI152NLin2009cAsym_desc-denoised.nii.gz
		done

		# concatenate all four runs into a single file
		3dTcat -prefix $out_dir/sub-001-denoised.nii.gz \
			   $out_dir/sub-001_ses-01_task-story_run-01_space-MNI152NLin2009cAsym_desc-denoised.nii.gz \
			   $out_dir/sub-001_ses-01_task-story_run-02_space-MNI152NLin2009cAsym_desc-denoised.nii.gz \
			   $out_dir/sub-001_ses-01_task-story_run-03_space-MNI152NLin2009cAsym_desc-denoised.nii.gz \
			   $out_dir/sub-001_ses-01_task-story_run-04_space-MNI152NLin2009cAsym_desc-denoised.nii.gz 

		# copy T1w image for visualization 
		cp [sample_project directory]/data/bids/derivatives/fmriprep/sub-001/anat/sub-001_space-MNI152NLin2009cAsym_desc-preproc_T1w.nii.gz $out_dir


Seed-based exploration
-----------------------

AFNI provides a way of exploring functional connectivity in your dataset through a simple seed-based correlation analysis via the InstaCorr program. 

Go to your output directory, and launch AFNI.
.. code-block:: bash

		$ cd [output directory]
		$ afni &

In the AFNI window, click on ‘UnderLay’ and select the anatomical image copied from the BIDS directory (“sub-001_space-MNI152NLin2009cAsym_desc-preproc_T1w.nii.gz”). 

* Click ‘Define Overlay’ to expand the window. 
* Click on the ‘Setup ICorr’ in top right corner to reveal this new window:



