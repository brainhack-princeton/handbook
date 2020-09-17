:orphan:

===================================================
Using tmux to create persistent server sessions
===================================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

``tmux`` is a command-line terminal multiplexer for Unix-like systems. When working on a remote server, you can use ``tmux`` to create persistent remote sessions. If you get disconnected from the remote server, the ``tmux`` session will keep running. You can attach and detach from these remote sessions, and create multiple windows or panes in a given session. You can control ``tmux`` using key combinations; you first type a prefix key combination (by default ``ctrl + b``) followed by additional command keys. The full ``tmux`` documentation can be found `here <http://man.openbsd.org/OpenBSD-current/man1/tmux.1>`_. The GNU ``screen`` program provides similar functionality (`documentation <https://www.gnu.org/software/screen/manual/screen.html>`_).

Creating a new ``tmux`` session
===============================

Typically, you want to create a tmux session on a remote server. You can also create a tmux on your local machine to use the multiplexing functionality, but the session will not persist if you shut down your local machine.

.. code-block:: bash

    # login to the server and create a new session called "mysession"
    $ ssh -X username@server
    $ tmux new -s mysession
    
Here, the argument ``new`` (or ``new-session``) creates a new session and the flag ``-s`` indicates a session name (``mysession``) of your choice. You are now inside the tmux session ``mysession``, and this session will persist whether you’re attached to it or not. You may want to create and name separate tmux sessions for different experiments or tasks (e.g., ``tmux new -s narratives``). You may need to reload Linux environment ``modules`` or reactivate ``conda`` environments in a new tmux session.

Attaching and detaching existing sessions
=========================================

When you log onto a server (via ssh), you can check if you have any existing session running.

.. code-block:: bash

    # list existing tmux sessions
    $ tmux ls

You can reattach to an existing session to pick up where you left off.

.. code-block:: bash

    # attach to an existing tmux session
    $ tmux a -t mysession

Here, the argument ``a`` is used to "attach" to a session, and the flag ``-t`` indicates the "target" session (``mysession``).

To detach from the current session (i.e. the session you're currently attached to, or "in"), you can use the prefix combination followed by ``d`` (``ctrl + b, d``) or using ``tmux detach``.

Your tmux sessions will persist indefinitely on a remote server unless you terminate them (or the server is rebooted). You can terminate an existing ``tmux`` session without being attached to that session.

.. code-block:: bash

    # terminate an existing tmux session
    tmux kill-session -t mysession

You can also terminate the session you're currently attached to using the prefix key combination followed by ``x`` (``ctrl + b, x``; confirm with ``y``), or by exiting the shell normally using ``exit``.

Navigating multiple windows and panes
=====================================

Within a ``tmux`` session, you can create multiple "windows" and within each window you can create multiple "panes". You can create a new "window" within your current ``tmux`` session using the prefix key combination and ``c`` (``ctrl + b, c``) or ``tmux new-window``. You can navigate directly to this window using the prefix key combination and the window number (``ctrl + b, [0-9]``), or you can flip to the next (``ctrl + b, n``) or the previous (``ctrl + b, p``) windows. 

You can split a ``tmux`` window into multiple panes. The key combination ``ctrl + b, %`` splits a window vertically into two side-by-side panes, whereas ``ctrl + b, "`` splits the window horizontally into upper and lower panes. You can use ``ctrl + b, [arrow-key]`` to navigate between panes.

Customizing your ``tmux`` configuration
=======================================

You can modify your ``tmux`` functionality by creating a :blue:`.tmux.config` file. This file should be located in your home directory (``cd ~`` on a Unix-like machine)—i.e., in your home directory on the server for using ``tmux`` on the server. Common modifications include changing the prefix key combination from ``ctrl + b`` to the more ergonomic ``ctrl + a`` from GNU ``screen``, or increasing the number of lines tmux keeps in the history. You can find example :blue:`.tmux.config` files online, or copy mine on scotty into your home directory: :blue:`/usr/people/snastase/.tmux.conf`

There are many ways of customizing your ``tmux`` configuration, as well as renaming, navigating, and otherwise manipulations windows and panes. You can explore the full functionality of ``tmux`` (on a Unix-like machine) using ``man tmux``. For common commands (e.g., manipulating windows, panes, etc.), you can find many cheat sheets online, as well a concise list of useful commands below.

``tmux`` commands cheat sheet
=============================
.. code-block:: RST

    tmux new -s [name]          # start a new tmux session
    tmux ls                     # list existing sessions
    tmux a -t [name]            # attach to an existing session
    tmux kill-session -t [name] # terminate target (-t) session
    ctrl + b, x                 # terminate current session
    ctrl + b, d                 # detach from current session
    ctrl + b, c                 # create new window in current section
    ctrl + b, [0-9]             # switch to numbered window
    ctrl + b, n                 # switch to next window
    ctrl + b, p                 # switch to previous window
    ctrl + b, %                 # split window horizontally into panes
    ctrl + b, "                 # split window vertically into panes
    ctrl + b, [arrow-key]       # navigate panes using arrow keys

`Return to tips and tricks <../06-01-tipsSplashPage.html>`_

