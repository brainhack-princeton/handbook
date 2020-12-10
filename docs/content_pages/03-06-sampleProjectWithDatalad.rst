.. _sampleProjectWithDatalad:

==========================================
Using DataLad to version control your data
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>
    <style> .orange {color:orange} </style>

.. role:: blue
.. role:: red
.. role:: orange

Before we begin, you should be aware that there is already an amazing `DataLad Handbook <http://handbook.datalad.org/en/latest/>`_ with super detailed documentation and tutorials. We definitely recommend you start there when learning about DataLad. The goal of this page is to help you apply DataLad commands and principles to your own BIDS-formatted dataset on your institution's server. 

Do this once: Install DataLad in a conda environment 
====================================================

We recommend installing DataLad in a conda environment on the server. This will allow you to use DataLad to track data you are storing and modifying on the server. 

If you have already setup a pygers conda environment following the instructions on our `conda tip page <hack_pages/conda.html>`_, you are good to go! The DataLad package was installed as part of the setup. Go ahead and login to the server, activate your pygers environment and proceed. 

.. code-block:: bash

    # login to scotty or spock
    # activate pygers environment
    $ conda activate pygers
    # test it out!
    $ datalad --version
    $ datalad --help   

If you already have Miniconda installed and want to create a new, datalad-only conda environment:

.. code-block:: bash

    # login to scotty or spock
    # create a new conda environment and name it datalad
    $ conda create -n datalad
    $ conda activate datalad
    # install DataLad
    $ conda install -c conda-forge datalad
    # test it out!
    $ datalad --version
    $ datalad --help   

If you want to install datalad as part of one of your other, pre-existing conda environments:

.. code-block:: bash

    # login to scotty or spock
    $ conda activate <myenv>
    # install DataLad
    $ conda install -c conda-forge datalad
    # test it out!
    $ datalad --version
    $ datalad --help   

Finally, if you haven't done this in the past, you should configure your Git identity. 

.. code-block:: bash

    # check if your git identity is already configured
    $ git config --list 
    # if you are already configured, you should see your user.name and user.email listed

    # if you still need to configure
    $ git config --global --add user.name "FirstName LastName" 
    $ git config --global --add user.email youremail@blah.com

Great! Now you are ready to start using DataLad on the server! 

Start tracking existing data with DataLad
=========================================

For this demo, we will show you how to apply DataLad commands to the Pygers sample dataset (i.e., a pre-existing dataset). You can also take this workflow and apply it to your own pre-existing, BIDS-formatted dataset. Before jumping straight in to using DataLad on your own dataset, we recommend practicing with the sample dataset to familiarize you with DataLad commands and general principles.

If you are practicing with our sample dataset, make sure you have already worked through :ref:`converting data to BIDS<converting>`, :ref:`quality control with MRIQC<mriqc>`, and :ref:`preprocessing with fMRIprep<fmriprep>`. You should have a version of the sample dataset living in your personal directory (e.g., :blue:`jukebox/YOURLAB/USERNAME/sample_project`) with the corresponding derivatives. Alternatively, if you want to cheat and skip these steps :), you can copy our sample project output to your personal directory. 

.. code-block:: bash

	# copy sample output to your personal directory and call it sample_project
	$ cp -r /jukebox/norman/pygers/handbook/sample_project_output_v20.2.0 /jukebox/YOURLAB/USERNAME/sample_project

The (abbreviated) structure of the :blue:`/sample_project` directory should be the following:

.. code-block:: bash

   └── sample_project
       └── code
           └── analysis
           └── preprocessing
           └── task
       └── data
           └── behavioral
           └── bids
               └── sub-001
               └── derivatives
                   └── deface 
                   └── fmriprep
                   └── freesurfer
                   └── mriqc
           └── dicom
           └── work

We will make :blue:`/sample_project` our highest level dataset (we will refer to this as the "superdataset"). Then we will create a series of "subdatasets". Subdatasets are really standalone datasets, with their own git log history and .gitignore files. For example, this will allow others (or your future self) to clone a subdataset alone, without cloning your entire dataset. In this demo, we will make the following directories their own (sub)datasets: 

* :blue:`/code` 

* :blue:`/data/bids`

* :blue:`/derivatives/deface`

* :blue:`/derivatives/fmriprep`

* :blue:`/derivatives/freesurfer`

* :blue:`/derivatives/mriqc`  

There are also some files and directories that we want to ignore (or leave "untracked"). This is either because we aren't worried about version controlling certain directories (e.g., :blue:`/data/work`) or because files might contain sensitive information that we don't want to share or make publicly available (e.g., :blue:`/data/dicom` and anatomical scans that have not been defaced). We will make sure to add directories and files that we do not want to track into the appropriate dataset's .gitignore file. 

Let's get started! First, make sure you have activated your datalad conda environment and navigate to the :blue:`/sample_project` in your personal directory. Notice on the command line, :orange:`(` datalad :orange:`)` indicates you are working in your datalad conda environment (this could also say :orange:`(` pygers :orange:`)` if you are working in your pygers conda environment). The working directory is included in :orange:`[` brackets :orange:`]`.   

.. code-block:: bash

    [~]$ conda activate datalad
    (datalad) [~]$ cd /jukebox/YOURLAB/USERNAME/sample_project

*Step 1: Setup your highest level dataset*
------------------------------------------

.. code-block:: bash

    # create a new dataset
    (datalad) [sample_project]$ datalad create -c text2git --description "Princeton pygers sample dataset" -f .
    # don't forget the period at the end to indicate current directory!

    # check your commit history
    (datalad) [sample_project]$ git log

You should see two commits, each with your name <email> (from git config) as the Author and the Date of your commit. These commits were automatically generated when you ran ``datalad create``). An example below:

.. code-block:: bash

    commit 1b2cea79ad11d17e1fd44c8047b6fd62da8e7dc1
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 16:51:48 2020 -0400

        Instruct annex to add text files to Git

    commit 92f5ddc455310e8af325f0a3843957fd5246af26
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 16:51:31 2020 -0400

        [DATALAD] new dataset

Now we can use ``datalad status`` to see which directories and files are "untracked" or "modified". 

.. code-block:: bash

    (datalad) [sample_project]$ datalad status

You should see 1 untracked file (:blue:`.DS_Store`) and 2 untracked directories (:blue:`/code` and :blue:`/data`).

Before proceeding, you need to add a couple things to a .gitignore file. Warning! You will need to use vim.
`Getting started with vim <https://opensource.com/article/19/3/getting-started-vim>`_.

After modifying your .gitignore file, you will commit your modification using a ``datalad save`` command.  

.. code-block:: bash

    (datalad) [sample_project]$ vim .gitignore

    # Add the following to your gitignore:
    # *.DS_Store
    # data/dicom
    # data/work

    # commit .gitignore modification
    (datalad) [sample_project]$ datalad save -m "add gitignore" .gitignore

You will now see one more commit in this dataset's history:

.. code-block:: bash

    # check your commit history
    (datalad) [sample_project]$ git log

    commit d49a496f1a629f69f627a2707f7171941179eaba
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 16:59:46 2020 -0400

        add gitignore

Now, if you check ``datalad status`` you should see that :blue:`.DS_Store` is no longer listed as an untracked file.

*Step 2: Setup your /code dataset*
----------------------------------

Now let's add a new (sub)dataset. Remember, this will be a standalone dataset with its own commit history (git log) and .gitignore file. However, when we create this dataset, we will "link" to our superdataset, and the time and date that we created this (sub)dataset will be tracked in the superdataset's git log history.

A couple of notes about the command options we are including below:

* we are using the ``--no-annex`` flag here because this directory only contains code files and not large data files
* the ``-d^`` flag is what "links" this dataset to the superdataset
* note that the last input (``./code``) is the path to the directory we want to make a dataset (relative to your working directory)  

.. code-block:: bash

    # create a new dataset
    (datalad) [sample_project]$ datalad create --no-annex -c text2git -f -d^ ./code

    # check your superdataset commit history
    (datalad) [sample_project]$ git log

You will see that there is a new commit that was logged when you ran ``datalad create``. However, the commit message is not very helpful: 

.. code-block:: bash

    commit 8af8f77009abc45880a6adad2cee9576871998b7
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Thu Aug 27 14:18:37 2020 -0400

        [DATALAD] Recorded changes

What we can do is amend the most recent commit and modify the commit message to something more descriptive:

.. code-block:: bash

    # modify most recent commit message
    (datalad) [sample_project]$ git commit --amend

Using vim, edit commit message to say: [DATALAD] Add code directory dataset

Now your most recent commit should look like this: 

.. code-block:: bash

    # check superdataset commit history
    (datalad) [sample_project]$ git log

    commit 8af8f77009abc45880a6adad2cee9576871998b7
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Thu Aug 27 14:18:37 2020 -0400

        [DATALAD] Add code directory dataset

Great! Now let's start looking at the code dataset.

.. code-block:: bash

    # move into your code directory
    (datalad) [sample_project]$ cd code

    # check out the status of directories/files and the git history
    (datalad) [code]$ datalad status # see which files/directories are untracked
    (datalad) [code]$ git log

You should see several commits in the git history, going all the way back to our old, pre-covid lifetime (Feb 20 2020)! This is because the code from the original sample dataset (before you copied to your own directory) was setup with git tracking. Then you can see there are the two commits corresponding to creating this new dataset and the ``-c text2git`` command we included when we ran ``datalad create``. Notice that this dataset has a completely new git history independent of the superdataset!    

.. code-block:: bash

    commit 8f5e3dbee686ac07edcc2d59a31ee232844d8a71
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 17:06:22 2020 -0400

        Instruct annex to add text files to Git

    commit d5d0254c6eedf7fdc09f96c4632334ed80dd2e0f
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 17:06:21 2020 -0400

        [DATALAD] new dataset

    # ...many other commits...

    commit 7e1fddcd5e17a72b93a570a88475fcf3ded2f30b
    Author: Elizabeth McDevitt <eam7@scotty.pni.Princeton.EDU>
    Date:   Thu Feb 20 11:09:12 2020 -0500

        Initial commit of handbook preprocessing code

Next we will add a .gitignore file for this code dataset, and commit the directories/files within :blue:`/code`. 

.. code-block:: bash

    # make sure you are in the code directory
    (datalad) [code]$ vim .gitignore

    # Add the following to your gitignore:
    # *.DS_Store
    
    # Commit .gitignore modification
    (datalad) [code]$ datalad save -m "add gitignore" .gitignore

    # Commit all code files
    (datalad) [code]$ datalad save -m "add code files"

    # Optional: setup and link to a remote GitHub repository if you haven't done this already
    (datalad) [code]$ git remote add origin [github-repo-url]

You should see two new commits in your code dataset git history: 

.. code-block:: bash

    (datalad) [code]$ git log

    commit d68b035e7de4e750b0fa0ce10f9d9d15a9d9820e
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 17:50:00 2020 -0400

        add code files

    commit 9c0f6245455e0bfda94b577fd3da0e7f9435d188
    Author: Lizzie McDevitt <emcdevitt8287@gmail.com>
    Date:   Wed Aug 12 17:07:18 2020 -0400

        add gitignore

Now go back up a level to the :blue:`/sample_project` directory and check ``datalad status``. You should see that :blue:`/code` is modified and :blue:`/data` is untracked. Next we will commit the modifications to :blue:`/code` only so that these changes are logged in the superdataset's git history. IMPORTANT: Make sure you include the ``-u`` flag at the end of the save command so that **ONLY** modifications (and **NOT** untracked files) are committed (``-u`` stands for "updated"). 

.. code-block:: bash

    # go up a level
    (datalad) [code]$ cd ..
    (datalad) [sample_project]$ datalad status
    (datalad) [sample_project]$ datalad save -m "add files to code dataset" -u

Now your superdataset git history has a commit that tracks what modifications were made to the code (sub)dataset. 

.. code-block:: bash

	(datalad) [sample_project]$ git log --oneline

	9933052 add files to code dataset
	8af8f77 [DATALAD] Add code directory dataset
	d49a496 add gitignore
	1b2cea7 Instruct annex to add text files to Git
	92f5ddc [DATALAD] new dataset

And let's compare this to the git history for the code dataset:

.. code-block:: bash

	(datalad) [sample_project]$ cd code
	(datalad) [code]$ git log --oneline

	d68b035 add code files
	9c0f624 add gitignore
	8f5e3db Instruct annex to add text files to Git
	d5d0254 [DATALAD] new dataset
	7e1fddc Initial commit of handbook preprocessing code

Notice that each dataset has its own git history!

*Step 3: Setup your /data/bids dataset*
---------------------------------------

Now we will add the :blue:`/data/bids` directory as its own (sub)dataset. Ultimately, we will track all of the raw BIDS-formatted nifti files for each subject in this dataset. However, keep in mind that the :blue:`/bids` directory also contains :blue:`/derivatives`. Since we want the various derivatives directories to become their own (sub)datasets, we will need to follow a slightly different workflow here so that we don't accidentally commit :blue:`/derivatives` to our :blue:`/data/bids` dataset. 

.. code-block:: bash

    # make sure you are in the sample_project directory
    # create a new dataset
    (datalad) [sample_project]$ datalad create -c text2git --description "Princeton pygers sample dataset raw BIDS files" -f -d^ ./data/bids

    # edit the unuseful commit message
    (datalad) [sample_project]$ git commit --amend

    # edit commit message to say: [DATALAD] Add BIDS dataset

    # move into the bids directory
    (datalad) [sample_project]$ cd data/bids

    # add and edit .gitignore file
    (datalad) [bids]$ vim .gitignore

    # add the following to your gitignore:
    # *.DS_Store
    # */*/anat/*T1w.nii.gz

    # commit .gitignore modification only
    (datalad) [bids]$ datalad save -m "add gitignore" .gitignore

    # check your bids dataset git log
    (datalad) [bids]$ git log --oneline

    677ac37 add gitignore
    471744c Instruct annex to add text files to Git
    c7cddba [DATALAD] new dataset

And that is it for now! Don't run any other ``datalad save`` commands for the bids dataset until you have finished adding derivatives (sub)datasets! You can check your ``datalad status`` and you should see that all files and directories are "untracked". 

If you want to check that you setup your .gitignore correctly, you can run a couple of checks. 

.. code-block:: bash

    (datalad) [bids]$ datalad status derivatives/*

You should see :blue:`/deface`, :blue:`/fmriprep`, :blue:`/freesurfer`, and :blue:`/mriqc` listed as untracked directories.  

.. code-block:: bash

    (datalad) [bids]$ datalad status */*/anat/*

You should see the :blue:`T1w.json` file listed as untracked, but NOT the :blue:`T1w.nii.gz` file listed because you added the :blue:`T1w.nii.gz` file to .gitignore. 

*Step 4: Setup your /derivatives/deface dataset*
------------------------------------------------

For the next four datasets, you will follow the same workflow of (1) adding a new dataset, (2) editing the commit messages in the higher level dataset git logs to be useful, (3) add and ``datalad save`` a .gitignore file, (4) ``datalad save`` the files *within* the dataset, and (5) then do a ``datalad save`` in the higher level dataset. Here we go! 

.. code-block:: bash

    # from your bids directory, create a new dataset
    (datalad) [bids]$ datalad create -c text2git --description "Princeton pygers sample dataset defaced files" -f -d^ ./derivatives/deface

    # edit the commit message in your bids dataset log
    (datalad) [bids]$ git commit --amend
    # edit commit message to say: [DATALAD] Add deface dataset

    # edit the commit message in your sample_project dataset log
    (datalad) [bids]$ cd ../..
    (datalad) [sample_project]$ git commit --amend
    # edit commit message to say: [DATALAD] Add deface dataset

    # move into deface directory and create a .gitignore
    (datalad) [bids]$ cd data/bids/derivatives/deface
    (datalad) [deface]$ vim .gitignore

    # add the following to your gitignore:
    # *.DS_Store

    # commit .gitignore only
    (datalad) [deface]$ datalad save -m "add gitignore" .gitignore

    # commit the contents of derivatives/deface
    (datalad) [deface]$ datalad save -m "add defaced T1w files"

    # go back two levels to the bids directory and check the status
    (datalad) [deface]$ cd ../..
    (datalad) [bids]$ datalad status

You should see that the :blue:`/derivatives/deface` dataset is "modified". Everything else is "untracked". Next you will run a ``datalad save`` command from your :blue:`/bids` directory using the ``-u`` flag. This will commit the modifications **ONLY**. 

.. code-block:: bash

    # don't forget the -u flag!!
    (datalad) [bids]$ datalad save -m "files added to deface dataset" -u

You have now finished adding the deface dataset, including tracking the contents of the deface dataset. These changes have been logged in the git history of the sample_project (super)dataset, the bids (sub)dataset, and deface (sub)dataset. Go ahead and inspect those git logs. 

.. code-block:: bash
	
    # from the deface directory
    (datalad) [deface]$ git log --oneline
    
    3b56d62 add defaced T1w files
    a788851 add gitignore
    a0b3191 Instruct annex to add text files to Git
    85a9219 [DATALAD] new dataset

    # from the bids directory
    (datalad) [bids]$ git log --oneline

    a5d1b0a files added to deface dataset
    f6e0260 [DATALAD] Add deface dataset
    677ac37 add gitignore
    471744c Instruct annex to add text files to Git
    c7cddba [DATALAD] new dataset

    # from the sample_project directory
    (datalad) [sample_project]$ git log --oneline

    0fd4b47 [DATALAD] Add deface dataset
    9933052 add files to code dataset
    8af8f77 [DATALAD] Add code directory dataset
    d49a496 add gitignore
    1b2cea7 Instruct annex to add text files to Git
    92f5ddc [DATALAD] new dataset

*Step 5: Setup your /derivatives/fmriprep dataset*
--------------------------------------------------

.. code-block:: bash

    # from your bids directory, create a new dataset
    (datalad) [bids]$ datalad create -c text2git --description "Princeton pygers sample dataset fmriprep derivatives" -f -d^ ./derivatives/fmriprep

    # edit the commit message in your bids dataset log
    (datalad) [bids]$ git commit --amend
    # edit commit message to say: [DATALAD] Add fmriprep dataset

    # edit the commit message in your sample_project dataset log
    (datalad) [bids]$ cd ../..
    (datalad) [sample_project]$ git commit --amend
    # edit commit message to say: [DATALAD] Add fmriprep dataset

    # move into fmriprep directory and create a .gitignore
    (datalad) [bids]$ cd data/bids/derivatives/fmriprep
    (datalad) [fmriprep]$ vim .gitignore

    # add the following to your gitignore:
    # *.DS_Store
    # */*/anat/*T1w.nii.gz

    # commit .gitignore only
    (datalad) [fmriprep]$ datalad save -m "add gitignore" .gitignore

    # check that anat files are actually ignored
    (datalad) [fmriprep]$ datalad status */*/anat/*

    # commit the contents of derivatives/fmriprep
    (datalad) [fmriprep]$ datalad save -m "add fmriprep output files"

    # go back two levels to the bids directory and commit changes at that level
    # don't forget the -u flag!!
    (datalad) [fmriprep]$ cd ../..
    (datalad) [bids]$ datalad save -m "files added to fmriprep dataset" -u

*Step 6: Setup your /derivatives/freesurfer dataset*
----------------------------------------------------

.. code-block:: bash

    # from your bids directory, create a new dataset
    (datalad) [bids]$ datalad create -c text2git --description "Princeton pygers sample dataset freesurfer derivatives" -f -d^ ./derivatives/freesurfer

    # edit the commit message in your bids dataset log
    (datalad) [bids]$ git commit --amend
    # edit commit message to say: [DATALAD] Add freesurfer dataset

    # edit the commit message in your sample_project dataset log
    (datalad) [bids]$ cd ../..
    (datalad) [sample_project]$ git commit --amend
    # edit commit message to say: [DATALAD] Add freesurfer dataset

    # move into freesurfer directory and create a .gitignore
    (datalad) [bids]$ cd data/bids/derivatives/freesurfer
    (datalad) [freesurfer]$ vim .gitignore

    # add the following to your gitignore:
    # *.DS_Store

    # commit .gitignore only
    (datalad) [freesurfer]$ datalad save -m "add gitignore" .gitignore

    # commit the contents of derivatives/freesurfer
    (datalad) [freesurfer]$ datalad save -m "add freesurfer output files"

    # go back two levels to the bids directory and commit changes at that level
    # don't forget the -u flag!!
    (datalad) [freesurfer]$ cd ../..
    (datalad) [bids]$ datalad save -m "files added to freesurfer dataset" -u

*Step 7: Setup your /derivatives/mriqc dataset*
-----------------------------------------------

.. code-block:: bash

    # from your bids directory, create a new dataset
    (datalad) [bids]$ datalad create -c text2git --description "Princeton pygers sample dataset mriqc derivatives" -f -d^ ./derivatives/mriqc

    # edit the commit message in your bids dataset log
    (datalad) [bids]$ git commit --amend
    # edit commit message to say: [DATALAD] Add mriqc dataset

    # edit the commit message in your sample_project dataset log
    (datalad) [bids]$ cd ../..
    (datalad) [sample_project]$ git commit --amend
    # edit commit message to say: [DATALAD] Add mriqc dataset

    # move into mriqc directory and create a .gitignore
    (datalad) [bids]$ cd data/bids/derivatives/mriqc
    (datalad) [mriqc]$ vim .gitignore

    # add the following to your gitignore:
    # *.DS_Store

    # commit .gitignore only
    (datalad) [mriqc]$ datalad save -m "add gitignore" .gitignore

    # commit the contents of derivatives/mriqc
    (datalad) [mriqc]$ datalad save -m "add mriqc output files"

    # go back two levels to the bids directory and commit changes at that level
    # don't forget the -u flag!!
    (datalad) [mriqc]$ cd ../..
    (datalad) [bids]$ datalad save -m "files added to mriqc dataset" -u

*Step 8: Cleanup higher level datasets*
---------------------------------------

Almost there! Now you will save all the untracked files and directories in your bids dataset, which should **ONLY** be the files and data directories at the bids level since all derivatives were already tracked or ignored. You can check this with ``datalad status``. 

.. code-block:: bash

    (datalad) [bids]$ datalad status derivatives/*

    # save all modified and untracked files/directories
    (datalad) [bids]$ datalad save -m "add BIDS data created using HeuDiConv"

Finally, go back to the highest level (i.e., the :blue:`sample_project` superdataset) and save modifications.

.. code-block:: bash

    (datalad) [bids]$ cd ../..
    (datalad) [sample_project]$ datalad status # /data/bids should be modified
    (datalad) [sample_project]$ datalad save -m "added BIDS files to data/bids dataset"

Congrats! You are all setup to version control all the data and code from the sample project. Make sure you reference the `DataLad Handbook <http://handbook.datalad.org/en/latest/>`_ to explore all the functionality and incredible things you can do with DataLad as you grow your dataset and analyze data! 