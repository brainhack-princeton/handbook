.. _contribute:

=================
How to contribute
=================

Thank you for your interest in contributing to this handbook!

This handbook is still under construction and there are severals ways you can contribute to our efforts, such as submitting an `issue <https://github.com/brainhack-princeton/handbook/issues/new/>`_ or a pull request, or by having a discussion with anyone on the Pygers team in a non-Github communication channel!

If you would like to contribute via a pull request, we think that's great! There are still plenty of chapters that need to be written and your contributions will be invaluable. Here are the steps you can take to submit a pull request starting from scratch.

Submitting an issue
===================

`Issues <https://github.com/brainhack-princeton/handbook/issues/new/>`_ can be used to keep track of bugs, enhancements, suggestions, and the like! Instructions for how to do this can be found `in this link <https://guides.github.com/features/issues/>`_.

Submitting a pull request
=========================

Things to set up once
---------------------

In order to have a copy of the repo on your local computer and be able to render the website locally (which are necessary to set up the workflow to contribute), these are **steps you need to do only once**. You don't have to do these steps again after things are up and running locally!!

1. First, you have to go to the `Github repo <https://github.com/brainhack-princeton/handbook>`_ for the handbook and **fork it**:

.. image:: images/fork_repo.png
  :width: 600px
  :align: center
  :alt: fork the repo!
  :class: with-border

* Follow the instructions that appear on the page to fork the repo to the correct location. 

2. After you successfully fork the repo, you want to **clone the repo** on your local computer. From there, you can make edits using your favorite source code text editor, such as `Sublime Text <https://www.sublimetext.com/>`_.

* Go to where you just forked the handbook repo on your Github repository.
* Click on "Clone or download" and copy the URL to clone the repo.
    * *NOTE: In the image below, the arrow points to information about where you forked the repo from.*

.. image:: images/clone_repo.png
  :width: 600px
  :align: center
  :alt: clone the repo!

* In your terminal window, change directory to the location where you want the clone of the repo to live. Then, clone the repo using the URL you copied in the previous step.

.. code-block:: bash

    # change directory to the place where you want the cloned repo
    cd Desktop/princeton_handbook/
    # clone the repo
    git clone [URL]

3. Next, you want to **create a conda environment** where you can install all of the necessary requirements to render the notebook locally. 

* *NOTE: You will have to activate this conda environment whenever you work on the notebook.*

.. code-block:: bash

    # create conda environment called "princeton_handbook"
    conda create --name princeton_handbook python=3
    # activate the conda environment "princeton_handbook"
    conda activate princeton_handbook

4. Now, you want to **download important packages** that are needed to render the website locally. In the folder *handbook*, you will find two files `setup.py` and `requirements.txt` that need to be called to install the necessary packages.

.. code-block:: bash

    # change directory to the 'handbook' folder
    cd handbook/
    # use python to install the things in 'setup.py'
    python setup.py install
    # use pip to install the things in 'requirements.txt'
    pip install -r requirements.txt

5. Since some of the artwork/files that we use might be svg files, you also need to **install librsvg** in order to render those files.

.. code-block:: bash

    # install librsvg
    conda install -c conda-forge librsvg

How to make edits
-----------------

In this section, we will describe how you can make edits to the handbook, both in the sense of the general workflow you should adapt when working locally and also how to submit a pull request when you think your changes are ready to be merged to the real website. However, first, we will go over the general organization of the repo to give you a sense of where things are!

Organization of the repo
~~~~~~~~~~~~~~~~~~~~~~~~
Although the folder of the cloned repo will have lots of folders and files, you are actually only going to work from the sub-folder *docs*. 

.. image:: images/path_to_content_pages.png
  :width: 600px
  :align: center
  :alt: screenshot of path to content pages
  :class: with-border

Specifically, chances are that you will most likely just make changes to the rst files in the folder *content_pages*. 

    * **IMPORTANT:** You should not make changes to the filenames in the *content_pages* folder unless you also change the *contents.rst.inc* or (better yet) talk with Paula to make sure that changing a filename doesn't break other things.

Here, we also want to highlight the location of the html files that will be generated when you render the handbook locally:

.. image:: images/path_to_index_html.png
  :width: 600px
  :align: center
  :alt: screenshot of path to the html of the index
  :class: with-border


* *NOTE: When you want to look at the handbook locally (once you generate these html files), you will want to open `index.html`. This will open the home page of the handbook on your internet browser.*


The general workflow for edits
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. First, you will want to **render the handbook locally** so that you can get a sense of the impact of the changes you make on the website.

.. code-block:: bash

    # change directory to be in the outermost folder of the repo
    cd ~/Desktop/princeton_handbook/handbook
    # activate the conda environment
    conda activate princeton_handbook
    # render the handbook locally
    make build

* The output will look something like the screenshot below, with the location of the html pages living in the location circled in red. Double click on `index.html` and it will open a local version of the handbook in your internet browser.

.. image:: images/make_build_output.png
  :width: 400px
  :align: center
  :alt: output you get after 'make build'
  :class: with-border

2. Add the official handbook repository as the upstream remote:

.. code-block:: bash

    # add official repo as the upstream remote
    git remote add upstream https://github.com/brainhack-princeton/handbook


3. Set your master branch to track the upstream remote:

.. code-block:: bash
    
    # fetch the latest changes (but doesn't merge remote changes to your local files)
    git fetch upstream
    # track the upstream remote branch 
    git branch -u upstream/master

4. Pull any new commits in the official handbook repo to keep your master branch up to date:

.. code-block:: bash

    # fetches and merges the remote changes to your local files
    git pull --ff-only

.. note::
    
    You won't be able to push changes you make directly to the official handbook repo. Instead, you will have to submit pull requests and the moderators/owners of the repo will review your pull request and decide whether they want to accept and merge your changes with the official handbook repo.

    For this reason, it is **highly recommended** that you don't make any changes to the `master` branch of your forked repo. Instead, there should be a 1-to-1 relationship between a feature you want to change and a pull request. In other words, you should create a new branch for every issue you want to change so that you can submit separate pull requests for every thing you want to modify.

5. When you start working on a new feature, create/checkout a new branch for that feature:

.. code-block:: bash

    # create and switch to new branch called 'new-feature'
    git checkout -b [new-feature]
      e.g., git checkout -b testing

6. Using your favorite source code text editor, make changes to the the document you want to modify. Use ``make build`` to (a) view your changes and (b) make sure that your changes haven't messed up the rendering of the handbook.

* When you're making changes, it might be easy to lose track of what were the exact files that were modified. You can use ``git status`` to view the files that were changed in the working directory.

.. image:: images/screenshot_git_status.png
  :width: 500px
  :align: center
  :alt: screenshot of output for 'git status'
  :class: with-border

7. You want to add, commit, and push your changes to your feature branch in your forked repo.

.. code-block:: bash

    # add a modified file in the working directory to the staging area
    git add docs/content_pages/01-01-howto.rst

    # commit the change with an informative message
    git commit -m "Added new content to how-to file"

    # check to make sure that you added the modified file to the staging
    git status

.. image:: images/screenshot_git_status2.png
  :width: 500px
  :align: center
  :alt: screenshot of 2nd output for 'git status'
  :class: with-border

.. code-block:: bash

    ## push modified files to your feature branch on your fork
    # the *first* time you push to your new feature branch on your fork
    git push --set-upstream origin [new-feature]
      e.g., git push --set-upstream origin testing
    # for *subsequent* pushes to this feature branch
    git push

Actually submitting a pull request
----------------------------------

Once you are satisfied with the changes you have pushed to your forked repo, you are ready to submit a pull request! This can be done directly on terminal, but the instructions below show how you can submit and manage a pull request from the Github online interface.

.. important::

    Before you submit a pull request, make sure that your code renders the handbook locally on your computer!!

1. On the Github page of your forked repo, make sure that you pushed the changes you committed (see where the arrow is pointing below) and that you are in the correct new-feature branch (in the dotted circle). **Press 'new pull request'** to initiate a new pull request (in the solid box).

.. image:: images/github_page_after_push.png
  :width: 600px
  :align: center
  :alt: screenshot of forked repo before pull request
  :class: with-border

2. Leave any comments in the text box and then submit the pull request by pressing 'Create pull request', which is boxed in below.

* *NOTE: The dotted box below also shows you the info about what repo (on the right) you are trying to merge, via a pull request, to the official handbook repo (on the left). You want to make sure that you see a notice saying that the branches are able to merge!*

.. image:: images/making_pull_request.png
  :width: 600px
  :align: center
  :alt: screenshot of making a pull request
  :class: with-border

3. Congratulations! You have submitted a pull request. You will now have to wait for a moderator for the official handbook to review your changes and merge your pull request to the oficial repo. 

* However, this sometimes doesn't happen right away. The moderators might want you to make some changes before accepting your merge request. If this is the case, they will contact you.

.. image:: images/pull_request_screenshot.png
  :width: 600px
  :align: center
  :alt: screenshot of after submitting a pull request
  :class: with-border

Github cheat sheet
==================

The tutorial above just touches the tip of the iceberg of all the things that you can (and may want to) do using Github. The cheat sheet below goes into more detail about the various things that you can do!

.. image:: extra_files/Github_Cheat_Sheet.png
  :width: 600px
  :align: center
  :alt: github cheat sheets
  :class: with-border

Download the Github Cheat Sheet :download:`here. <extra_files/Github_Cheat_Sheet.pdf>`


