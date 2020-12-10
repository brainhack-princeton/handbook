:orphan:

=================================================
Using Git and GitHub to version control your code
=================================================

.. raw:: html

    <style> .blue {color:blue} </style>

.. role:: blue

What is Git and why should we use it? And what is GitHub?
=========================================================

*Git* is a **version control system** for tracking changes to your code over time. Git can track the history of your code; this means that if you mess something up, you can go back in time and recover a previous version of your code. Providing the full provenance of your code also makes your workflow more transparent for others. Here's a `Git cheatsheet <https://education.github.com/git-cheat-sheet-education.pdf>`_ to familiarize yourself with version control using Git.

*GitHub* is a **web platform** that hosts collaborative software development and distribution using Git. The web interface allows you to see the history of your code and share your code with others. For more information about Git and GitHub, check out `this article <https://codeburst.io/git-and-github-in-a-nutshell-b0a3cc06458f>`_!

Configure your Git identity
===========================

Set this up once! Every time you make a commit, your name and contact info will be included as the "Author". 

.. code-block:: bash

    # check if git identity is configured
    $ git config --list # check for user.name and user.email

    # otherwise configure your name and email
    $ git config --global --add user.name "FirstName LastName"
    $ git config --global --add user.email youremail@blah.com 

Initialize a Git repository on your local machine
=================================================

Let's say you are starting a new project and you want to make sure you are using Git to track all of your code files. We are going to call this imaginary directory `git-demo`. You can follow along by creating your own `git-demo` directory anywhere on your local machine (or on the server). 

.. code-block:: bash

    $ mkdir git-demo
    $ cd git-demo

    # initialize repo
    $ git init

You are now using Git to track files in your `git-demo` directory! Let's add a file and start tracking it. 

.. code-block:: bash

    $ vim demo.txt
    # use your text editor to type something in demo.txt

    $ git status #demo.txt is an untracked file
    $ git add demo.txt #stage this file for commit
    $ git commit -m "add demo.txt file" #commit with useful message

    # check your git log to see the commit history
    $ git log
    $ git log -p -n 1
    $ git log --oneline

Create a remote repository on GitHub
====================================

Now let's say you want this repository to live remotely on GitHub. This will allow you to 1) sync your repository across multiple machines and 2) make your code easy to share.

First, make sure you have an account on `GitHub <https://github.com/>`_. 

From your GitHub account, create a new repository. Name the repository `git-demo`. Don't add a README, .gitignore, or license. 

Next, you will follow the instructions to "...push an existing repository from the command line." Copy the url listed after ``git remote add origin``. Go back to your terminal where you created your local `git-demo` directory.  

.. code-block:: bash

    $ git remote add origin https://github.com/<USERNAME>/git-demo.git
    $ git branch -M main
    $ git push -u origin main

Refresh your GitHub repository. You should see your demo.txt file on GitHub! 

Now you can go ahead and add a README on GitHub. Select "Add a README". Type anything into the README. Then choose the option to Commit directly to the main branch, and "Commit new file". 

The README file now exists on the remote (GitHub) version of your repository. In order to keep your remote and local repos in sync, go back to your terminal command line. 

.. code-block:: bash

    $ git pull
    $ ls

You should see that the README.md file now exists in your local `git-demo` directory!

Clone your repository onto another machine
==========================================

Now imagine that you have a second computer (e.g. the stimulus presentation computer at the scanner) and you want your code accessible on that machine as well. In this scenario, you can edit code on your laptop, push those changes to GitHub, then pull those changes to the computer at the scanner. If you then edit a file at the scanner, you can push those changes to GitHub and pull that change to your laptop. In this way, the code on your laptop, the scanner computer, and GitHub will all be in sync! In this scenario, the "second computer" (or third, or fourth, etc.) could also be a collaborator's computer, your home desktop, etc. 

For now, we are going to clone the repo to the same computer you are working on now and imagine that this is our second computer. On GitHub, copy your repository's url. 

From your local terminal, move outside of `git-demo` and create a new directory called `second-computer`. 

.. code-block:: bash

    $ cd ..
    $ mkdir second-computer
    $ cd second-computer

    # clone repo
    $ git clone https://github.com/<USERNAME>/git-demo.git
    $ ls

You should see that you now have a `git-demo` directory on your "second computer". Next, let's make some changes to the demo.txt file on your "second computer". 

.. code-block:: bash

    $ cd git-demo
    $ vim demo2.txt
    # use your text editor to add anything to demo2.txt

    $ git status #demo2.txt is untracked
    $ git add demo2.txt #stage file for commit
    $ git commit -m "added file on second computer"
    $ git log

    # push changes to GitHub
    $ git remote -v #check that your GitHub repo is your remote
    $ git push -u origin main

Refresh GitHub. You should see demo2.txt in your repo. Now go back to your original ("first computer") `git-demo` directory and synchronize changes. 

.. code-block:: bash

    $ cd ../../git-demo
    $ git pull
    $ ls

And now you should see that demo2.txt exists in your original `git-demo` directory. Everything is synchronized!

As one last step, examine ``git log`` in both your original and second computer repos. Notice that the logs reflect the full commit history, regardless of if the commit happened in the original, second computer, or GitHub repository! 

General Git workflow
====================

Initialize Git in an empty or exisiting code directory on computer1 (``git init``). Setup a corresponding new repository on GitHub. Add GitHub as the remote to your computer1 repo (``git remote add origin <url>``). Clone the GitHub repo to computer2 (``git clone <url>``). 

Keep everything synchronized! Follow this workflow when working from computer1 or computer2 (or computer3, etc.). 

.. code-block:: bash

    # make sure you are working with current version of code
    $ git pull #pull changes from GitHub

    # then make some changes...
    # edit a file, add new files, etc.

    # make sure you know what you changed
    $ git status #see modified or untracked files
    $ git diff <filename> #see what has changed for a specific file

    # the holy grail
    $ git add <filename> #stage file for commit
    $ git commit -m "meaningful message" #commit
    $ git push #push changes to GitHub

    $ git log #see commit history

Git cheat sheet
===============

.. code-block:: bash

    $ git init                       #start git tracking in a directory
    $ git remote add origin <github-repo-url> #link local repo to GitHub repo
    $ git remote -v                  #verify remote URL
    $ git clone <github-repo-url>    #copy GitHub repo to local machine

    $ git remote add <shortname> <url> #add a new remote and give it a name

    $ git pull                       #GitHub -> local repo
    $ git status                     #list modified and untracked files
    $ git add <filename>             #stage a specific file for commit
    $ git add --all                  #stage all changes
    $ git add --update               #stage modified (but not untracked) files
    $ git commit -m "useful message" #save everything in staging area
    $ git commit --amend             #edit last commit
    $ git push -u <remote> <branch>  #local repo -> GitHub, specifying which remote and which branch you want to push to
    $ git push                       #local repo -> GitHub

    $ git rm --cached <filename>     #untrack a file or directory
    $ git mv <filename>              #move or rename a file or directory

    $ git log                        #show commit history
    $ git log --oneline              #show commit history with one line for each commit
    $ git log -n 1                   #show only last commit
    $ git log -p                     #show detailed log
