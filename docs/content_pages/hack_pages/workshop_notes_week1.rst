:orphan:

==========================================
Pygers Workshop Notes - Week 1 (Fall 2020)
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

`Linux command line cheatsheet <https://appletree.or.kr/quick_reference_cards/Unix-Linux/Linux%20Command%20Line%20Cheat%20Sheet.pdf>`_

`Vim cheatsheet <https://vim.rtorr.com/>`_

`conda cheatsheet <https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html>`_

`Glossary <../06-03-glossary.html>`_

Basic bash commands
-------------------

.. code-block:: bash

    # login to the server 
    $ ssh -XY netID@scotty.pni.princeton.edu
    $ pwd

    $ cd /jukebox/LAB/YOURDIRECTORY
    $ pwd
    $ ls
    $ ls -l
    $ ls -a

    # make a workshop directory
    $ mkdir pygers_workshop
    $ ls

    # copy new_study_template from pygers to your workshop directory, call it sample_study
    $ cp -r /jukebox/norman/pygers/handbook/new_study_template pygers_workshop/sample_study

    # explore sample_study
    $ tree
    $ cd sample_study/code
    $ ls

    # rename something
    $ mv -v task task_code
    $ ls

    # delete something
    $ rm -r task_code
    $ ls
    
    # make a new directory
    $ mkdir task

    # see which modules are available on the cluster
    $ module avail
    $ module load fsl
    $ module list
    $ module purge

Using vim
---------

From your server terminal window:

.. code-block:: bash

    $ cd preprocessing

    # print contents of file
    $ cat globals.sh

    # practice going from command mode to insert mode
    $ vim globals.sh
    
    # i to go to insert mode; esc to go to command mode
    # :q to quit without saving

Open a LOCAL terminal window: 

.. code-block:: bash

    # if you are running Catalina OS, you need to change your default shell
    # This only has to be done one time!!
    $ chsh -s /bin/bash

    # edit local .bash_profile to add aliases
    $ vim .bash_profile

    # enter insert mode (i) and add the following:
    # alias 'scotty'='ssh -XY netID@scotty.pni.princeton.edu'
    # alias 'spock'='ssh -XY netID@spock.pni.princeton.edu'
    # go back to command mode (esc)
    # :x to save and exit

    $ source .bash_profile
    $ scotty

You are now back on the server:

.. code-block:: bash

    # edit your linux .bashrc on the server
    $ cd ~
    $ vim .bashrc

    # enter insert mode (i) and add the following:
    # alias 'pygers'='/jukebox/LAB/YOURDIRECTORY/pygers_workshop'
    # go back to command mode (esc)
    # :x to save and exit

    $ pygers #this shouldn't work yet, you need to source your .bashrc
    $ source .bashrc
    $ pygers
    $ pwd

Setup a pygers conda environment
--------------------------------

.. code-block:: bash

    # install latest miniconda
    $ cd ~
    $ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    $ bash Miniconda3-latest-Linux-x86_64.sh
    $ source .bashrc

    # take a look at your .bashrc
    $ vim ~/.bashrc

    # if you don't want this base environment automatically loaded when you login:
    $ conda config --set auto_activate_base false

    # check your available conda environments
    $ conda env list
    $ conda --version
    $ conda --help

    # create environment called pygers
    $ conda create -n pygers
    $ conda env list

    # activate pygers environment and install packages
    $ conda activate pygers
    $ conda install git numpy pandas jupyter

    # check your install
    $ python --version
    $ conda list

    # deactivate conda environment
    $ conda deactivate pygers

`Return to workshop info <./syllabus2020.html>`_

