.. _sampleProject:

Dataset description
---------------------------------

We have gotten consent from a subject (sub-001) to scan him and share everything, including personally identifiable information. This is useful for learning because many available datasets have already removed personal information, which makes sense for obvious reasons. However, this isn’t always the best thing for learning how to preprocess datasets because the data shared is already in BIDS/NIfTI format, and/or already has the face removed. We’re giving you everything as if it has just come right from the scanner!

We’ve shared the dataset right from the beginning of where the files are located on the PNI cluster, as if you just transferred the folder from the scanner.

Here is the faux conquest location to simulate where it has come from the scanner console: 

.. code-block:: bash

    /jukebox/norman/pygers/conquest/0219191_mystudy-0219-1114

Here is the location of the study directory:

.. code-block:: bash

    /jukebox/norman/pygers/handbook/sample_project


Tasks in the sample project
~~~~~~~~~~~~~~~~~~~~~~~~~~~


We had sub-001 perform a couple of different tasks:

* **sound**: Sound check before scanning
* **story**: He listened to a story in the scanner. For more information on this specific story, see `Yeshurun et al 2017 <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5348256/>`_ describing the auditory stimulus.
* **faces**: He performed the face-matching task `Chai et al 2015 <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4474282/>`_.

Folder structure in the sample project directory and useful things
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*(not all scripts/folders are listed here)*
::

    --| sample_project      
        --| code    
            --| preprocessing               
                --| globals.sh  -- look how the specification of folders were set up 
                                here and adapt to your project accordingly  
            --| analysis    
                --| aparc+aseg_registration.sh  -- example script for freesurfer → EPI registration 
                --| resample.py -- function to resample to different grids
        --| data
            --| bids                
                --| sub-001     -- nifti converted files from running heudiconv
                --| derivatives 
                    --| mriqc   
                        --| derivatives
                        --| reports
                        --| logs
                    --| fmriprep    
                        --| sub-001
                        --| sub-001.html
                        --| logs    
                    --| freesurfer
            --| dicom           
                --| 0219191_mystudy-0219-1114   -- this is the entire folder that was transferred from 
                                the scanning folder in step1_preproc.sh
                --| check_volumes   -- outputs checking that all dicoms transferred
            --| T1w_defaced -- this is where the defaced anatomical gets moved
                --| sub-001_ses-01_T1w_defaced.nii.gz

How to use the sample project:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All of the sample codes are written for this sample project, so make sure you edit all of the relevant variables before you run! (Start with the **globals.sh** and make sure to edit your email for all of the slurm scripts!)

The basic hierarchy with the preprocessing scripts is that there is
::

        1) a slurm script: outer-most call to scheduler: use sbatch to run on command line
            a) bash script: command to call processing script like:
                - a singularity image call (fmriprep, mriqc)
                - a python scipt (like with pydeface or any python script you might want to run on the cluster


So if something doesn’t make sense, then start with the highest level script, and then work your way down to get a sense for what’s happening!
