:orphan:

==========================================
Pygers Workshop Notes - Week 2 (Fall 2020)
==========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

`conda cheatsheet <https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html>`_

Setup a pygers conda environment
--------------------------------

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

`Return to workshop info <./syllabus2020.html>`_

