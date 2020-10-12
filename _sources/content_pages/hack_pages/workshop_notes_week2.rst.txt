:orphan:

==========================================
Pygers Workshop Notes - Week 2 (Fall 2020)
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

What is conda? Why do we use it?
--------------------------------

*Conda* is a **package manager**, similar to brew, apt, or pip. This package manager allows us to keep track of your python versions and keep all dependencies encapsulated in an **environment**, that can be easily shared or reproduced. This is especially helpful if you have multiple projects that require different package versions. Importantly, this prevents things from breaking if you have packages for different projects that can cause conflicts with one another.


*Anaconda* is a free and open source **software distribution** for scientific computing that is managed by conda. It is pretty large to download, so you might want to use *Miniconda* instead. Miniconda is a minimal version of Anaconda.

Here is a `conda cheatsheet <https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html>`_ that you can use as you familiarize yourself with this package manager.

Set up a pygers conda environment
---------------------------------

You should setup your conda environment in the same "location" as your pygers_workshop working directory (i.e. either on your local machine if you are working locally, or on the server if you are working on the server). Follow the correct installation instructions below.

Server installation:

.. code-block:: bash

    # download latest miniconda for Linux in your home directory
    $ cd ~
    $ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    
    # run installation
    $ bash Miniconda3-latest-Linux-x86_64.sh

    # if you don't want this base environment automatically loaded when you login:
    $ conda config --set auto_activate_base false
    
    # source and take a look at your .bashrc
    $ source .bashrc
    $ vim .bashrc

    # you can delete the installation file if you want
    $ rm -r Miniconda3-latest-Linux-x86_64.sh

Local installation:

.. code-block:: bash

    # download latest miniconda for MacOSX in your downloads directory
    $ cd ~/Downloads
    $ curl -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh

    # run installation (it should install in your home directory by default)
    $ bash Miniconda3-latest-MacOSX-x86_64.sh

    # if you don't want this base environment automatically loaded when you login:
    $ conda config --set auto_activate_base false
    
    # source and take a look at your .bashrc
    $ cd ~
    $ source .bash_profile
    $ vim .bash_profile

    # you can delete the installation file if you want
    $ rm -r ~/Downloads/Miniconda3-latest-MacOSX-x86_64.sh

Everybody can now continue the conda setup following the same set of instructions:

.. code-block:: bash

    # check your conda setup
    $ cd ~
    $ which conda #see where it is installed
    $ conda env list #you should see a base environment listed
    $ conda --version #latest is 4.8.5 as of Oct-12-2020
    $ conda --help #useful commands
    
    # if you need to update conda
    $ conda update -n base -c defaults conda

    # create environment called pygers
    $ conda create -n pygers
    $ conda env list

    # activate your pygers environment
    $ conda activate pygers

    # check your python version
    $ python --version #latest is 3.8.5 as of Oct-12-2020
    # make sure you have python version 3.8 (as opposed to 2.7) 
    
    # if you need to update python:
    $ conda install python
    $ python --version

    # install packages into your pygers environment
    $ conda install git numpy pandas jupyter

    # check your install; versions listed are latest as of Oct-12-2020
    $ conda list
    $ git --version #2.23.0
    $ jupyter --version #core is 4.6.3
    $ python -c "import numpy; print(numpy.version.version)" #1.19.1
    $ python -c "import pandas; print(pandas.__version__)" #1.1.3

    # deactivate conda environment
    $ conda deactivate

What is Git and why should we use it? And what is GitHub?
---------------------------------------------------------

*Git* is a **version control system**, which means that it is a way in which project files can be manages and tracked over time. This is important because this means that Git can track the entire history of whatever files you are working on. Messed something up and wish you could go back in time? With Git, this is actually possible! Here is a `git cheatsheet <https://education.github.com/git-cheat-sheet-education.pdf>`_ that you can use as you familiarize yourself with this version control system.

*GitHub* is a **web-based service** that allows you to do version control using Git. It has an easy-to-use web interface that allows you to clearly see your file history (in part, by highlighting additions and deletions to your files) and do many other cool things. For more information about Git and GitHub, check out `this article <https://codeburst.io/git-and-github-in-a-nutshell-b0a3cc06458f>`_!

Practice Demo: Familiarize yourself with Git!
---------------------------------------------
*add here*

Using Git/GitHub with our Sample Project
----------------------------------------

1. Create a new GitHub repository (`link <https://docs.github.com/en/enterprise/2.15/user/articles/create-a-repo>`_ to instructions) where you will track the files inside :blue:`pygers_workshop/sample_project/code/`.

2. Our sample project, which you copied last week, already has a .git attached to it that is `linked <https://github.com/brainhack-princeton/handbook-code>`_ to a repo on our Pygers GitHub account:

.. code-block:: bash

    # show the URL that Git has stored in local repo
    $ git remote -v
    # OUTPUT:
    #   origin    https://github.com/brainhack-princeton/handbook-code.git (fetch)
    #   origin    https://github.com/brainhack-princeton/handbook-code.git (push)

3. You want to remove the link to the Pygers GitHub account and link it to the repo you created in Step 1 in your own GitHub account:

.. code-block:: bash

    $ cd [YOUR_LOCAL_PATH]/pygers_workshop/sample_project/code/
    $ git remote -v
    $ git remote rm origin
    $ git remote add origin [URL_TO_YOUR-REPO]
    # confirm that your origin remote is linked to your github repo
    $ git remote -v

4. Push the changes to your GitHub repo (in a way to automatically push to your repo in the future).

.. code-block:: bash

    $ git push -u origin master

Refresh your GitHub page online. You should be able to see the contents inside :blue:`pygers_workshop/sample_project/code/` on the repo.

5. Add .DS_Store to your your .gitignore and push it to your GitHub.

.. code-block:: bash

    $ git status # .DS_Store should appear in the list of untracked files
    $ vim .gitignore
    $ .DS_Store
    $ git add .gitignore
    $ git commit -m 'adding gitignore'
    $ git push
    $ git status # .DS_Store should NOT appear in the list of untracked files

6. There are several things you need to change in the :blue:`globals.sh` file. Edit these things using vim (`vim preprocessing/globals.sh`)

- Comment out `module load anacondapy/5.3.1`
- Set the **scanner_dir** to the location where the data lives:
    - for PNI folks, the location is :blue:`/jukebox/norman/pygers/conquest`
    - fot non-PNI folks, this should be the path to where you downloaded and saved the sample data
- Edit **project_dir** to where you have the sample_study code (e.g., /jukebox/LAB/YOURNAME/pygers_workshop/sample_study)

Now, you need to commit and push the changes to your globals.sh file:

.. code-block:: bash

    $ git add preprocessing/globals.sh
    $ git commit -m 'updating globals directory'
    $ git push


`Return to workshop info <./syllabus2020.html>`_

