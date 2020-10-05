.. _glossary:

********
Glossary
********


Computing
---------

.. glossary::

    bash
		Bourne-again shell; a commonly-used Unix command language

    CLI
        command-line interface; see command line

    cluster
		group of networked high-performance computers that can be remotely accessed for increased computing power; see HPC and server

    command line
		interface for processing commands to a computer as lines of text; sometimes referred to as command-line interface (CLI); see terminal, and compare to GUI

    conda
        package manager used for Python and other languages; contrast with pip

    container
		self-contained virtual computing environment that includes all dependencies for increased portability and reproducibility; see Docker and Singularity

    CPU
        central processing unit

    Docker
		platform used for packaging software and computing environments into containers (https://www.docker.com/); typically used on personal computers, but not on multi-user servers due to requiring root privileges; see container and Singularity

    GPU
        graphical processing unit

    GUI
		graphical user interface

    HPC
        high-performance computing; using large-scale computing resources over long periods of time to accomplish a task; sometimes referred to as high-throughput computing (HTC); see parallelization

    HTC
        high-throughput computing; using large-scale computing resources over long periods of time to accomplish a task; sometimes referred to as high-performance computing (HPC); see parallelization

    IDE
        integrated development environment; software that integrates a code editor, debugger, compiler, interpreter etc; e.g., PyCharm, Spyder, Jupyter Lab

    job scheduler
		software that manages tasks submitted by multiple users on a high-performance computing cluster; e.g., Slurm, PBS, HTCondor

    MATLAB
        commercial, closed-source software for mathematical analysis

    mount
		mounting remote storage volumes allows you to interact with data stored on a server using local computing resources; particularly useful for visualization; on Mac, using Finder > Go > Connect to server; on Linux, use sshfs

    OS
        operating system (e.g., Linux, MacOS, Windows)

    parallelization
        type of computing where multiple sub-tasks are carried out simultaneously, typically by assigning sub-tasks to different CPUs or threads; see job scheduler

    pip
        package manager for Python; contrast with conda

    Python
        free and open source software with wide range of functionality

    RAM
        random-access memory; rapid and dynamic "working" memory used doing processing, in contrast to longer-term data storage (e.g., hard disk), which requires slower read/write processing

    server
        typically a remote institutional computer system or cluster that provides high-performance computing services for "clients"; see cluster and HPC

    shell
        command-line interface for interacting with an operating system; e.g., sh, bash, csh, tcsh, zsh

    SSH
		secure shell; a secure connection to a remote computer or server

    terminal
		command-line interface for interacting with a computer (or shell); sometimes referred to as a terminal emulator; see command line

    text editor
		application for editing scripts in an easy way (outside of terminal); e.g., vim, Emacs, gedit, nano, Sublime, Atom

    tmux
		terminal multiplexer that allows you to attach and detach from persistent sessions on a remote server; also screen

    Vim
		extension of the "vi" text editor; commonly used on Linux systems; exit Vim by pressing "esc" then ":" then "x" (save and exit) or "q" (exit without saving) then "return"; see text editor

    virtualization
        see container; OS-level virtualization vs. virtual machine

    virtual machine
        e.g., Vagrant, VirtualBox

Computing at PNI
----------------

.. glossary::

    apps
        use this for navigating the fileserver (e.g. moving or copying files)

    bucket/jukebox
        PNI's fileserver. Each lab has a volume on the fileserver, and all the lab volumes are accessible via apps, spock and scotty.

    scotty
        use this for interactive sessions on the server. Scotty is well-equipped for developing software to run on spock, as well as facilitating interactive workloads that are a poor fit for the computational clusters (e.g. using a gui).

    SLURM
        program used to schedule jobs and manage resource utilization on the computational cluster (i.e. spock). SLURM will allocate your job to one or multiple nodes on spock. 

    spock
        PNI's computational cluster

MRI Acquisition
---------------

.. glossary::

    bandwidth
        range of frequencies associated with signal reception; higher bandwidth typically increases noise

    BOLD
        blood-oxygen-level-dependent; signal indexed by the T2* contrast in fMRI

    DICOM
        Digital Imaging and Communications in Medicine; common file format for MRI images (as well as other types of medical images, e.g., CT); format for raw images exported from Siemens scanner after data acquisition

    EPI
        echo-planar imaging; commonly used MRI acquisition technique that relies on multiple gradient echoes to traverse k-space in a zig-zag fashion allowing rapid slice acquisition; see GRE

    GRAPPA
        generalized autocalibrating partial parallel acquisition; in-plane acceleration technique in k-space; contrast with SENSE; see iPAT

    GRE
        gradient echo; commonly used MRI acquisition technique where a rephasing gradient is applied at opposite polarity during T2, resulting in a "gradient echo"

    iPAT
        integrated parallel imaging techniques; refers to a family of techniques for in-plane acceleration, typically either in image space (e.g., SENSE) or in k-space (e.g., GRAPPA); an acceleration factor of iPAT = 2 with EPI means that half the number of echoes are acquired, accelerating acquisition;  contrast with multiband and SMS

    isotropic
        typically used with reference to voxel sizes to indicate that voxels have the same extent in all three dimensions (e.g., 3 x 3 x 3 mm voxels are 3 mm isotropic voxels)

    mSENSE
        modified sensitivity encoding; Siemens-specific name for in-plane acceleration in image space; see SENSE and iPAT

    multiband
        simultaneous multislice (SMS) acceleration; contrast with iPAT; see SMS

    NIfTI
        `Neuroimaging Informatics Technology Initiative <https://nifti.nimh.nih.gov/>`_; common file format for volumetric (f)MRI images; NIfTI images contain less metadata than DICOM images

    SENSE
        sensitivity encoding; in-plane acceleration technique in image space; Siemens refers to this technique as mSENSE; contrast with GRAPPA; see iPAT

    SMS
        simultaneous multislice; multiband acceleration technique in which multiple slices are acquired simultaneously; an acceleration factor of SMS = 2 means that two slices are collected simultaneously; contrast with iPAT; see multiband

    SNR
        signal-to-noise ratio; typically the mean signal value divided by the standard deviation (over time or space)

    TE
        echo time; time between radio frequency (RF) pulse and receipt of echo signal; corresponds to the duration required to acquire a single slice

    TR
        repetition time; duration of time between the acquisition of two consecutive functional volumes

    tSNR
        temporal signal-to-noise ratio; see SNR

    voxel
        volumetric (3D) pixel; MRI volumes are composed of voxels; voxel size (e.g., 3 mm) determines the spatial resolution of the images

Open science
------------

.. glossary::

    `Anaconda <https://www.anaconda.com/>`_
	    common Python distribution including many data science packages; relies on the conda Python package manager; contrast with miniconda; see conda

    `arXiv <https://arxiv.org/>`_
        open-access preprint server for quantitative science (e.g., mathematics, physics, statistics) manuscripts prior to peer-reviewed publication; hosted by Cornell University

    `BIDS <https://bids.neuroimaging.io/>`_
        Brain Imaging Data Structure; convention for organizing neuroimaging (meta)data that facilitates analysis and sharing

    `bioRxiv <https://www.biorxiv.org/>`_
        open-access preprint repository for posting biology (including neuroscience) manuscripts prior to peer-reviewed publication; hosted by Cold Spring Harbor Laboratory (CSHL)

    `BrainIAK <https://brainiak.org/>`_
        open-source python toolbox for advanced neuroimaging analysis

    `BSD License <https://opensource.org/licenses/BSD-3-Clause>`_
        permissive software license with minimal restriction on re-use and distribution; contrast with GPL

    `CC <https://creativecommons.org/licenses/>`_
        Creative Commons; family of licenses with varying types of restriction; e.g., CC0 (unrestricted release into public domain); CC-BY (requires attribution), CC-SA (requires share-alike)

    `git <https://git-scm.com/>`_
        free and open-source version control software for tracking code changes

    `GitHub <https://github.com/>`_
        web platform for hosting and distributing software developed using git; commercial subsidiary of Microsoft

    `GNU <https://www.gnu.org/home.en.html>`_
        GNU's Not Unix; Unix-like operating system composed of entirely free software (typically released under GPL); see GPL
	
    `GPL <https://www.gnu.org/licenses/gpl-3.0.en.html>`_
        GNU General Public License; a free "copyleft" license with share-alike requirements ensuring that derivative work be distributed under the same license, thus restricting commercialization; contrast with BSD License and MIT License

    `Jupyter <https://jupyter.org/>`_
        open-source web-based interactive computational environment for Python, R, Julia, etc; includes "Jupyter Notebook" and "Jupyter Lab"; derivative of IPython

    `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_
        lightweight, minimal Python distribution relying on the conda package manager; contrast with Anaconda; see conda

    `MIT License <https://opensource.org/licenses/MIT>`_
        permissive software license; contrast with GPL

    `OpenNeuro <https://openneuro.org/>`_
		repository for publishing and sharing neuroimaging data in BIDS format

    `OSF <https://osf.io/>`_
        Open Science Framework, free and open source project management tool (often used for preregistration of research hypotheses and task designs during or before data acquisition)

    `PsyArXiv <https://psyarxiv.com/>`_
        preprint repository for posting psychology manuscripts prior to peer-reviewed publicationo; hosted by the Center for Open Science
