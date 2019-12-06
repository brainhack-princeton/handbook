.. _contribute:

=================
How to contribute
=================

Thank you for your interest in contributing to this handbook!

This handbook is still under construction and there are severals ways you can contribute to our efforts, such as submitting an `issue <https://github.com/brainhack-princeton/handbook/issues/new/>`_ or a pull request, or by having a discussion with anyone on the Pygers team in a non-Github communication channel!

On this page, we will address the following topics to help you contribute to the construction of this handbook:

* `Submitting an issue`_
* `Submitting a pull request`_
* `Github cheat sheet`_

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

.. _ShortAnchor:

Submitting an issue
===================

`Issues <https://github.com/brainhack-princeton/handbook/issues/new/>`_ can be used to keep track of bugs, enhancements, suggestions, and the like! Instructions for how to do this can be found `in this link <https://guides.github.com/features/issues/>`_. You can submit an issue along with a pull request if you have suggestions about how to resolve the issue. However, you can submit an issue by itself and someone else can take lead on trying to incorporate your suggestion or resolve the bug.

Submitting a pull request
=========================

You can also contribute via a pull request, which would allow you to write code that can be merged to the official handbook repo (i.e., that can end up on the world wide web). There are still plenty of chapters that need to be written and your contributions will be invaluable.

Here, we are going to delineate the steps needed to render the notebook locally on your computer so that you can make and test edits, along the steps you need to take to submit a pull request:

* `Things to set up once`_
* `Organization of the repo`_
* `The general workflow for edits`_

*Things to set up once*
-----------------------

In order to have a copy of the repo on your local computer and be able to render the website locally (which are necessary to set up the workflow to contribute), these are the **steps you need to do only once**. You don't have to do these steps again after things are up and running locally!!

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

1. First, you have to go to the `Github repo <https://github.com/brainhack-princeton/handbook>`_ for the handbook and **fork it**:

.. image:: images/fork_repo.png
  :width: 700px
  :align: center
  :alt: fork the repo!
  :class: with-border

*The image above, the red box highlights the button you need to press to fork the original handbook repo.*

* Follow the instructions that appear on the page to fork the repo to the correct location. 

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

2. After you successfully fork the repo, you want to **clone the repo** on your local computer. From there, you can make edits using your favorite source code text editor, such as `Sublime Text <https://www.sublimetext.com/>`_.

* Go to where you just forked the handbook repo on your Github repository.
* Click on "Clone or download" and copy the URL to clone the repo.

.. figure:: images/clone_repo.png
  :width: 700px
  :align: center
  :alt: clone the repo!

  
*The image above, the red box highlights the button you need to press to get the URL to clone the repo. The arrow points to info about the location of the original repo you forked.*

* In your terminal window, change directory to the location where you want the clone of the repo to live. Then, clone the repo using the URL you copied in the previous step.

.. code-block:: bash

    # change directory to the place where you want the cloned repo
    cd Desktop/princeton_handbook/
    # clone the repo
    git clone [URL]

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

3. Next, you want to **create a conda environment** where you can install all of the necessary requirements to render the notebook locally. 

.. code-block:: bash

    # create conda environment called "princeton_handbook"
    conda create --name princeton_handbook python=3
    # activate the conda environment "princeton_handbook"
    conda activate princeton_handbook

* *NOTE: You will have to activate this conda environment whenever you work on the notebook.*

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

4. Now, you want to **download important packages** that are needed to render the website locally. In the folder :blue:`handbook`, you will find two files :blue:`setup.py` and :blue:`requirements.txt` that need to be called to install the necessary packages.

.. code-block:: bash

    # change directory to the 'handbook' folder
    cd handbook/
    # use python to install the things in 'setup.py'
    python setup.py install
    # use pip to install the things in 'requirements.txt'
    pip install -r requirements.txt

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

5. Since some of the artwork/files that we use might be svg files, you also need to **install librsvg** in order to render those files.

.. code-block:: bash

    # install librsvg
    conda install -c conda-forge librsvg


*Organization of the repo*
--------------------------

If everything in the section above went well, you should have your forked repo on your local computer and a conda environment that has all of the necessary installations for you to render the handbook locally. Before we talk about how you can make edits, we first want to describe the organization of the repo to give you a sense of where things are!

Although the folder of the cloned repo will have lots of folders and files, you are actually only going to work from the sub-folder :blue:`docs`. 

.. image:: images/path_to_content_pages.png
  :width: 600px
  :align: center
  :alt: screenshot of path to content pages
  :class: with-border

*The image above highlights the location of the* :blue:`docs` *(in a red box) in reference to all of the other files in the repo.*

Specifically, chances are that you will most likely just make changes to the rst files in the folder :blue:`content_pages`. 

    * **IMPORTANT:** You should NOT make changes to the filenames in the :blue:`content_pages` folder unless you also change the :blue:`contents.rst.inc` or (better yet) talk with Paula to make sure that changing a filename doesn't break other things.

Here, we also want to highlight the location of the html files that will be generated when you render the handbook locally (:blue:`handbook/docs/_build/html`):


.. image:: images/path_to_index_html.png
  :width: 600px
  :align: center
  :alt: screenshot of path to the html of the index
  :class: with-border

*The image above highlights the location of the* :blue:`html` *folder (in a red circle) in reference to all of the other files in the repo, along with the location of the* :blue:`index.html` *file (in the red box).*

When you want to look at the handbook locally (once you generate these html files), you will want to open :blue:`index.html`. This will open the home page of the handbook on your internet browser.

*The general workflow for edits*
--------------------------------

Now that you have a general sense of how the repo is organized (and how you will render the handbook locally on your browser), we will delineate the general workflow you will take to make edits and eventually submit pull requests.

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

1. First, you will want to **render the handbook locally** so that you can get a sense of the impact of the changes you make on the website.

.. code-block:: bash

    # change directory to be in the outermost folder of the repo
    cd ~/Desktop/princeton_handbook/handbook
    # activate the conda environment
    conda activate princeton_handbook
    # render the handbook locally
    make build

* The output on your terminal will look something like the screenshot below, with the location of the html pages living in the location circled in blue. 

.. image:: images/make_build_output.png
  :width: 400px
  :align: center
  :alt: output you get after 'make build'
  :class: with-border

* Open up Finder and double click on :blue:`index.html`, which will be in the directory :blue:`handbook/docs/_build/html` as discussed in the previous section. This will open a local version of the handbook in your internet browser.

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

2. You only have to do this ONCE: **Add the official handbook repository as the upstream remote**.

.. code-block:: bash

    # add official repo as the upstream remote
    git remote add upstream https://github.com/brainhack-princeton/handbook

* :red:`Why are we doing this?` We want your local directory to point to two different remotes (or places on Github where code is stored). The first one should be the **origin**, which should point to your forked repo on Github. The second one should be the **upstream** branch, which should point to the official handbook repo on Github. Having this organization will allow you to pull changes from the upstream branch so that you can make edits on the most up-to-date version of the repo, while allowing you the flexibility to do work on your repo. To check that all of this holds true, run the following commands on your terminal:

.. code-block:: bash
    
    # view the remotes you currently have
    git remote
    # view the url of the git repo the origin remote points to
    git remote get-url origin
    # view the url of the git repo the upstream remote points to
    git remote get-url upstream

.. image:: images/looking_at_remotes.png
  :width: 700px
  :align: center
  :alt: looking at remotes

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

* You also want to set your master branch to track the upstream remote:

.. code-block:: bash
    
    # fetch the latest changes (but doesn't merge remote changes to your local files)
    git fetch upstream
    # track the upstream remote branch 
    git branch -u upstream/master

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

3. **Pull any new commits in the official handbook repo** to keep your master branch up to date:

.. code-block:: bash

    # fetches and merges the remote changes to your local files
    git pull --ff-only
    # push the commits to your forked repo
    git push origin master

* You have to do ``git push origin master`` in order to push any commits that you pulled from the official repo to your forked repo. 

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

.. note::
    
    You won't be able to push changes you make directly to the official handbook repo. Instead, you will have to submit pull requests and the moderators/owners of the repo will review your pull request and decide whether they want to accept and merge your changes with the official handbook repo.

    For this reason, it is **highly recommended** that you don't make any changes to the `master` branch of your forked repo. Instead, there should be a 1-to-1 relationship between a feature you want to change and a pull request. In other words, you should create a new branch for every issue you want to change so that you can submit separate pull requests for every thing you want to modify.

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

4. When you start working on a new feature, **create/checkout a new branch** for that feature:

.. code-block:: bash

    # create and switch to new branch called 'new-feature'
    git checkout -b [new-feature]
      e.g., git checkout -b testing

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

5. Using your favorite source code text editor, **make changes to the the document you want to modify**. Use ``make build`` to (a) view your changes and (b) make sure that your changes haven't messed up the rendering of the handbook.

* When you're making changes, it might be easy to lose track of what were the exact files that were modified. You can use ``git status`` to view the files that were changed in the working directory.

.. image:: images/screenshot_git_status.png
  :width: 500px
  :align: center
  :alt: screenshot of output for 'git status'
  :class: with-border

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

6. You want to **add, commit, and push your changes to your feature branch** in your forked repo.

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

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

7. Once you are satisfied with the changes you have pushed to your forked repo, you are ready to **submit a pull request**! This can be done directly on terminal, but the instructions below show how you can submit and manage a pull request from the Github online interface.

.. important::

    Before you submit a pull request, make sure that your code renders the handbook locally on your computer!!

* On the Github page of your forked repo, make sure that you pushed the changes you committed (see where the arrow is pointing below) and that you are in the correct new-feature branch (in the dotted circle). **Press 'new pull request'** to initiate a new pull request (in the solid box).

.. image:: images/github_page_after_push.png
  :width: 600px
  :align: center
  :alt: screenshot of forked repo before pull request
  :class: with-border

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

8. Leave any comments in the text box and then **submit the pull request by pressing 'Create pull request'**, which is boxed in below.

.. image:: images/making_pull_request.png
  :width: 600px
  :align: center
  :alt: screenshot of making a pull request
  :class: with-border

*The dotted box above also shows you the info about what repo (on the right) you are trying to merge, via a pull request, to the official handbook repo (on the left). You want to make sure that you see a notice saying that the branches are able to merge!*

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

9. Congratulations! You have submitted a pull request. You will now have to **wait for a moderator for the official handbook to review your changes and merge your pull request to the official repo**. 

.. image:: images/pull_request_screenshot.png
  :width: 700px
  :align: center
  :alt: screenshot of after submitting a pull request
  :class: with-border

* However, this sometimes doesn't happen right away. The moderators might want you to make some changes before accepting your merge request. If this is the case, they will contact you.

.. image:: images/decorative_line4.png
  :width: 700px
  :height: 8px
  :align: center
  :alt: decorative line

10. If your pull request gets approved and is merged to the offical handbook, **delete the branch** for the feature that was just approved. You can do this from the terminal or from the github page.

* On terminal:

.. code-block:: bash

    ## delete the branch (both locally and on your remote)
    git push <remote_name> --delete <branch_name>
      e.g., git push origin --delete testing

* On your forked repo, go to the branches tab.

.. image:: images/branches_on_repo.png
  :width: 700px
  :align: center
  :alt: screenshot of location of branches on repo
  :class: with-border

* Find the branch you want to delete, and press the trash can icon.

.. image:: images/delete_branch.png
  :width: 700px
  :align: center
  :alt: screenshot of deleting a branch
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


