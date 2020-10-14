:orphan:

==========================================
Pygers Workshop Notes - Week 2 (Fall 2020)
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

What is Conda? Why do we use it?
--------------------------------

*Conda* is a **package manager**, similar to brew, apt, or pip. This package manager keeps track of your Python installation, versions, and dependencies in an encapsulated **environment** that can be easily shared or reproduced. This is helpful if you have multiple projects that require different (potentially conflicting) software versions. You can activate and deactivate conda environments, and we'll use conda to install new packages into our environment.


*Anaconda* is a free and open source **software distribution** for scientific computing that is managed by conda. *Miniconda* is a minimal version of Anaconda.

Here's a `conda cheatsheet <https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html>`_ you can use to familiarize yourself with this package manager.

Set up a pygers conda environment
---------------------------------

You should setup your conda environment on the same computer as your pygers_workshop working directory (i.e. either on your local machine if you are working locally, or on the server if you are working on the server). Follow the correct installation instructions below.

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

Local installation (on MacOSX):

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

*Git* is a **version control system** for tracking changes to your code over time. Git can track the history of your code; this means that if you mess something up, you can go back in time and recover a previous version of your code. Providing the full provenance of your code also makes your workflow more transparent for others. Here's a `Git cheatsheet <https://education.github.com/git-cheat-sheet-education.pdf>`_ to familiarize yourself with version control using Git.

*GitHub* is a **web platform** that hosts collaborative software development and distribution using Git. The web interface allows you to see the history of your code and share your code with others. For more information about Git and GitHub, check out `this article <https://codeburst.io/git-and-github-in-a-nutshell-b0a3cc06458f>`_!

Demo: familiarize yourself with Git!
---------------------------------------------
In the following, we'll work through a simple exercise of version control with Git. We'll use a simple Python script to demo staging and committing changes, viewing your history, going back in time, and sharing code via GitHub.

.. code-block:: bash

    # activate conda environment and check git version
    $ conda activate pygers
    $ git --version

    # check if git identity is configured 
    $ git config --list # check for user.name and user.email

    # otherwise configure your name and email
    $ git config --global --add user.name "FirstName LastName" 
    $ git config --global --add user.email youremail@blah.com 

    # create a git demo directory in pygers_workshop
    $ mkdir git-demo
    $ cd git-demo

    # initialize a git repository (repo) in this directory
    $ git init

    # create silly example python script
    $ vim division.py

    # enter this into your text editor:
    n = int(input("Enter numerator: "))
    d = int(input("Enter denominator: "))
    print(n / d)

    # check git status now that we have a new file
    $ git status

    # add the new file to the staging area
    $ git add division.py
    $ git status

    # commit the new changes with an informative message
    $ git commit -m “Create division.py to cause me headaches later”

    # check the git log to see the commit history so far
    $ git status
    $ git log # also try `git log -p -n 1` or `git log --oneline`

    # try running our silly python script
    $ python division.py # enter some numbers

    # note that floats break this script
    # check your python version then try division with remainder
    # if you're using python 3, the ouput should be a fractional float
    # if you're using python 2, the default is integer division (yikes)

    # let's make an adjustment to our script
    $ vim division.py

    # enter this into your text editor:
    def num(n):
        try:
            return int(n)
        except ValueError:
            return float(n)

    n = num(input("Enter numerator: "))
    d = num(input("Enter denominator: "))
    print(n / d)

    # add and commit new changes
    $ git status
    $ git add division.py # or git add -u
    $ git commit -m “Update division.py to tolerate floats”

    # let's add a shebang to script
    $ vim division.py

    # enter this into your text editor:
    #!/usr/bin/env python

    def num(n):
        try:
            return int(n)
        except ValueError:
            return float(n)

    n = num(input("Enter numerator: "))
    d = num(input("Enter denominator: "))
    print(n / d)

    # and commit this third change
    $ git add division.py
    $ git commit -m "Add python shebang to division.py"

    # how is git tracking all this
    $ ls -al # see hidden .git dot-files

    # view differences between commits
    $ git log
    $ git diff SHA SHA # diff between two commit hashes

    # snoop around in the past using git checkout
    $ git checkout SHA # go back to your first commit
    $ less division.py # our script is in its previous state
    $ git log # the log is in its previous state

    # okay let's go back to the future
    $ git checkout master

    # undo recent commit(s) using reset
    $ git log
    $ git reset --mixed SHA
    $ git log # git log is in previous state

    # modify the script for a new commit
    $ vim division.py # our prior changes are still present

    # modify this line in your text editor:
    #!/usr/bin/env python3 # update our shebang to python3

    # commit this version instead
    $ git add division.py
    $ git commit -m "Add python3 shebang to division.py"
    $ git log

    # we can still find our orphaned commit (for now)
    $ git reflog # get commit hash for “Update…”
    $ git checkout SHA # or git reset to return to this commit
    $ git checkout master

    # create empty repository with no README, LICENSE on GitHub
    $ git remote add origin https://github.com/snastase/git-demo.git
    $ git push -u origin master

    # create README on GitHub
    $ git pull
    $ ls

    # on GitHub, click “Add file”, type LICENSE, and then click Choose license
    $ git pull
    $ ls

    # switch to another computer and clone repo from GitHub
    $ git clone https://github.com/snastase/git-demo.git

    # make some changes on your other computer
    $ vim division.py

    # update the script in your text editor:
    #!/usr/bin/env python3

    def num(n):
        try:
            return int(n)
        except ValueError:
            return float(n)

    n = num(input("Enter numerator: "))
    d = num(input("Enter denominator: "))
    print(f"Result: {n / d}")

    # commit and push changes to GitHub
    $ git add division.py
    $ git commit -m "Update result output format"
    $ git push

    # switch back to other computer and synchronize changes
    $ git pull

    # rename a file with git mv
    $ git mv division.py divide.py

    # untrack tracked file
    $ git rm --cached division.py

    # amend previous commit message
    $ git commit --amend

This is only a thin slice of Git functionality; there are many other powerful features. For example, check out the ":ref:`How to contribute<contribute>`" page of our handbook to familiarize yourself with the workflow for using Git to contribute to an existing software package.

Using Git/GitHub with our sample project
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

