:orphan:

===========================================
Using conda to manage software environments
===========================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

Here we will walk you through the steps to setup a "pygers" conda environment with recommended packages installed. 

What is Conda? Why do we use it?
================================

*Conda* is a **package manager**, similar to brew, apt, or pip. This package manager keeps track of your Python installation, versions, and dependencies in an encapsulated **environment** that can be easily shared or reproduced. This is helpful if you have multiple projects that require different (potentially conflicting) software versions. You can activate and deactivate conda environments, and we'll use conda to install new packages into our environment.

*Anaconda* is a free and open source **software distribution** for scientific computing that is managed by conda. *Miniconda* is a minimal version of Anaconda.

Here's a `conda cheatsheet <https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html>`_ you can use to familiarize yourself with this package manager.

Installing Miniconda
====================

You only need to install Miniconda once; you can create multiple conda environments based off of this Miniconda installation. You can setup a conda environment on your local machine and/or on the PNI server. Follow the correct set of installation instructions below. 

Server installation:

.. code-block:: bash

    # download latest miniconda for Linux in your home directory
    $ cd ~
    $ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    
    # run installation
    $ bash Miniconda3-latest-Linux-x86_64.sh

    # if you don't want this base environment automatically loaded when you login:
    $ conda config --set auto_activate_base false
    
    # source your .bashrc
    $ source .bashrc

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
    
    # source your .bash_profile
    $ cd ~
    $ source .bash_profile

    # you can delete the installation file if you want
    $ rm -r ~/Downloads/Miniconda3-latest-MacOSX-x86_64.sh

Create a new conda environment
==============================

.. code-block:: bash

    # check your conda setup
    $ cd ~
    $ which conda #see where it is installed
    $ conda env list #you should see a base environment listed
    $ conda --version #latest is 4.9.2 as of Dec-9-2020
    $ conda --help #useful commands
    
    # if you need to update conda
    $ conda update -n base -c defaults conda

    # create a new environment called pygers that runs python 3.9
    $ conda create -n pygers python=3.8
    $ conda env list
    # note you could choose to create a conda environment with python=2.7 or any other python version
    
    # activate your pygers environment
    $ conda activate pygers

    # check your python version
    $ python --version
    
    # if you need to update python:
    $ conda update python

    # if you want to upgrade between major python versions like 3.8 to 3.9
    $ conda install python=3.9
    $ python --version

Now any time you want to use this conda environment, you will need to ``conda activate pygers``. When you are done using the environment, you should ``conda deactivate``. 

Install packages
================

We recommend you install the following packages into your pygers conda environment as a good starting point. You can always add packages as you need them! 

Recommended packages: git, numpy, pandas, jupyter, nodejs, bids-validator, datalad, pydeface and fsleyes. Note you only need to install pydeface and fsleyes in *local* conda environments because the PNI server already has pydeface and fsleyes modules available for us to use. 

.. code-block:: bash

    # make sure your pygers environment is activated
    $ conda activate pygers

    # install first four packages
    $ conda install git numpy pandas jupyter

    # check your install; versions listed are latest as of Dec-09-2020
    $ conda list
    $ git --version #2.29.2
    $ jupyter --version #core is 4.7.0
    $ python -c "import numpy; print(numpy.version.version)" #1.19.4
    $ python -c "import pandas; print(pandas.__version__)" #1.1.5

    # install nodejs
    $ conda install -c conda-forge nodejs=11
    $ node -v #check node version (11.14.0)
    
    # install bids-validator
    $ npm install -g bids-validator
    $ which bids-validator #shows your installation location
    $ bids-validator -v #1.5.7

    # install datalad
    $ conda install -c conda-forge datalad
    $ datalad --version #0.13.5

    # install pydeface and fsleyes (local environment only)
    $ pip install pydeface
    $ pydeface --help #2.0.0
    $ conda install -c conda-forge fsleyes
    $ fsleyes --version #0.34.2

    # take a look at all installed packages in pygers environment
    $ conda list

Conda cheat sheet
=================

.. code-block:: bash

    # list available conda environments
    $ conda env list
    $ conda info --envs

    # create a new environment
    $ conda create -n $myenv python=$version

    # remove a conda environment
    $ conda env remove --name $myenv

    # activate and deactivate
    $ conda activate $myenv
    $ conda deactivate

    # update conda
    $ conda --version
    $ conda update -n base -c defaults conda

    # remove a package in the current environment
    $ conda remove $package