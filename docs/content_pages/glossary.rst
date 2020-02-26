.. _glossary:

********
Glossary
********


Computing
---------

.. glossary::

    container
		self-contained virtual computing environment that includes all dependencies for increased portability and reproducibility; see Docker and Singularity

	HPC
		high-performance computing; using large-scale computing resources over long periods of time to accomplish a task; sometimes referred to as high-throughput computing (HTC); see parallelization

    HTC
        high-throughput computing; using large-scale computing resources over long periods of time to accomplish a task; sometimes referred to as high-performance computing (HPC); see parallelization

    parallelization
        type of computing where multiple sub-tasks are carried out simultaneously, typically by assigning sub-tasks to different CPUs or threads; see job scheduler

    CPU
        central processing unit

    GPU
        TODO

    RAM
        TODO

    Docker
		platform using for packaging software and computing environments into containers (https://www.docker.com/); typically used on personal computers, but not on multi-user servers due to requiring root privileges; see container and Singularity

    OS
        operating system (e.g., Linux, MacOS, Windows)

    virtualization
        see container; OS-level virtualization vs. virtual machine

    virtual machine
        e.g., Vagrant, VirtualBox

    job scheduler
		software that manages tasks submitted by multiple users on a high-performance computing cluster; e.g., Slurm, PBS, HTCondor

    terminal
		command-line interface for interacting with a computer (or shell); somtimes referred to as a terminal emulator; see command line

    command line
		interface for processing commands to a computer as lines of text; somtimes referred to as command-line interface (CLI); see terrminal, and compare to GUI)

    GUI
		graphical user interface

    Vim
		extension of the "vi" text editor; commonly used on Linux systems; exit Vim by pressing "esc" then ":" then "x" (save and exit) or "q" (exit without saving) then "return"; see text editor

    mount
		mounting remote storage volumes allows you to interact with data stored on a server using local computing resources; particularly useful for visualization; on Mac, using Finder > Go > Connect to server; on Linux, use sshfs

    SSH
		secure shell; a secure connection to a remote computer

    cluster
		group of networked high-performance computers that can be remotely accessed for incraased computing power; see HPC aand server

    bash
		Bourne-again shell; a commonly-used Unix command language

    text editor
		application for editing scripts in an easy way (outside of terminal); e.g., vim, Emacs, gedit, nano, Sublime, Atom

    IDE
        integrated development environment; software that integrates a code editor, debugger, compiler, interpreter etc; e.g., PyCharm, Spyder, Jupyter Lab

    tmux
		terminal multiplexer that allows you to attach and detach from persistent sessions on a remote server; also screen

    server
        TODO

    shell
        sh, bash, csh, tcshr

MRI Acquisition
---------------

.. glossary::

	Bandwidth
		range of frequencies associated with signal reception.

	DICOM
		commonly used image format for MRI images (as well as other types of medical images like CT etc). This is the format that you will get your MRI-images in when taking them from the scanner after data acquisition.

	Nifti
		common used data format for (f)MRI images

	GRAPPA / mSENSE
		two parallel acquisition techniques that can shorten the acquisition time or increase the spatial resolution in the same examination time

	iPAT
		*to be added*

	SMS
		simultaneous multislice technique, acceleration in data acquisition

	TE
		echo time, time between RF (radio frequency) pulse and receipt of echo signal

	TR
		repetition time, length of time between two consecutive epi images

	Voxel
		volume element within your MR-image, your MR-image is a 3D matrix and each element of this matrix is referred to as voxel.

	EPI
		functional MRI scan (echo-planar imaging)

	BOLD
		Blood-oxygen-level-dependent

	GRE
		Gradient Echo, MRI technique for T2-weighted imaging that requires gradient echo signal

	SNR
		signal-to-noise ratio, relative contribution of true detected signal and random background noise

Open science
------------

.. glossary::

	`Github <https://github.com/>`_
		platforms that allows you to save version controlled scripts
	
	`OpenNeuro <https://openneuro.org/>`_
		Free and open platform to share neuroimaging data

	`OSF <https://osf.io/>`_
		Open Science Framework, free and open source project management tool (often used for preregistration of research hypotheses and task designs (during or before data acquisition)

	`brainIAK <https://www.biorxiv.org/>`_
		open-source python toolbox for advanced neuroimaging analysis

	Jupyter notebook
		open-source web-based interactive computational environment for Python and R

	`Anaconda <https://www.anaconda.com/>`_
		open-source distribution of Python and R data science packages
