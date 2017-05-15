% [git](http://www.git-scm.com/) and [github](www.github.com)
% Christian Groll

# Overview

## origin

- git was created to improve cooperative work on the Linux kernel:

> "Git is a free and open source distributed version control system
> designed to handle everything from small to very large projects with
> speed and efficiency."

## Why git?

- robust **cooperation**

. . .

- robust **synchronization** across multiple computers

. . .

- commit history: **restore past** project state
	- allows experimentation with software
	- source files often need to be saved in order to run their newest
     version 
	- if modifications are experimental and probably only temporary,
     the original stable version should exist as a checkpoint to
     return to 

. . .

- more generally: keep **multiple versions** of project (stable /
  development version)

## [github](www.github.com)

- free code hosting platform for git repositories

. . .

- extensive **features**:
	- issue tracking
	- markdown rendering, comment features
	- Wiki
	- automatic testing ([travis-ci](https://travis-ci.com/))
	- free static homepages ([gh-pages](https://pages.github.com/))

# Installation / configuration

## Setup targets

- install and configure git
- register at github
- enable ssh access to github

## On Linux machine

- git is usually installed upfront
- otherwise: use package manager (for example on Ubuntu)

	````sh
	sudo apt-get install git
	````

## [git config](https://help.github.com/articles/set-up-git/)

associate yourself with your work:

. . .

- user name:
	````sh
	git config --global user.name "cgroll"
	````

. . .

- email address:
````sh
git config --global user.email "groll.christian.edu@gmail.com"
````

##  github setup

- register at github
- [set up SSH keys](https://help.github.com/articles/generating-ssh-keys/)

## On Windows machine

- easiest way to install git: using [github for
  windows](https://windows.github.com/) (see [installation
  screencast](https://youtu.be/utYrgFLKFaY))

. . .

- installation will automatically exchange SSH keys

# Terminology

## Repository vs folder

- a git project is called repository

. . .

- a repository resides in a folder

. . .

- files within this folder are not automatically under control of git

. . .

- for all files within the repository git contains the current version
  and all past versions

## 

Files basically can be in one of the following states:

. . .

- NOT controlled by git:
	- either: files are visible in git
	- or: files can be ignored by `gitignore`

##

Controlled by git:

. . .

- current version is already part of the repository (**committed**)

. . .

- modified files:

	- either: modifications are not yet known by git
	- or: modifications are already **staged**

. . .

- overview command:

	````sh
	git status
	````

##

- files and changes need to be added to git:

	````sh
	git add someFile.txt
	````

. . .

- `git add` **adds** new files or changes **to staging area**

. . .

- staging area allows **grouping of changes** into meaningful chunks
  (**commit**): for example, all changes related to the creation of a
  certain graphic

## commits

- a **commit** is a group of **changes**, together with a reference to
  the last commit (**difference between states** of project)

. . .

- the **history** of a repository is a sum of **successive** changes
  expressed through **commits**

. . .

- in combination with all previous commits, a single **commit** can
  also be interpreted as a **full snapshot** of the project

. . .

- the project snapshot only exists for those files in the folder that
  are put under git's control

# Remotes

## 

using git for backup, synchronization or cooperation:

- multiple copies of a repository

. . .

- in principle, git is **decentralized**: no copy of the repo is
  special

. . .

- in order to pull from / push to other repository, both copies need
  to be connected

. . .

- usually: server or code hosting platform is the only copy of the
  repo that is always available $\Rightarrow$ it naturally becomes
  central main repo

## platforms

a number of git **hosting platforms**:

- [github](https://github.com/): free public repos
- [gitlab](https://about.gitlab.com/): free private repos
- [bitbucket](https://bitbucket.org/): free private repos

## clone

Copying an existing repository **from github**:

. . .

- https:

	````sh
	git clone https://github.com/cgroll/research_tools.git
	````

. . .

- ssh:
	````sh
	git clone git@github.com:cgroll/research_tools.git
	````

##

- to be able to synchronize with second copy of a repository you need
  its location

. . .

- instead of referencing copies with complicated urls, you can assign
  names 

. . .

- using `git clone` the original repository automatically gets the
  name `origin`

## storage

git **forgets nothing**:

. . .

- all committed versions will be stored inside the repository forever

. . .

- git uses data blobs to efficiently store **incremental** chunks

. . .

- efficient incremental storage only works for text files: a small
  change to a **binary file** will require git to store **two full
  versions** of the file

## github: storage

- github will store a repository with its full history

. . .

- using free **public** repositories:
	- do not commit **proprietary data** that you are not allowed to
     re-distribute
	- do not commit sensible data (**passwords**, ...)

## branches

- branches allow **multiple** different **versions** of project:
  stable vs development version

. . .

- design of branches encourages merging:
	- not meant for infinite second version
	- one single final outcome: **eventually** changes on other
     branches should be **merged to master**

. . .

- repos start with `master` branch by default

# Workflow

## Commit own changes

- **add modifications** to `git`:
	- `git add`
	- `git commit`

. . .

- modifications to files under control of git MUST be added

. . .

- new files may be kept outside of the repo, but cause problems when
  merging with state of repo where files are part of repo

## get changes from remote

- as all merges must occur locally, possible **changes** on the remote
  need to be **merged** first
	````sh
	git pull origin master
	````

. . .

- deal with **merge conflicts**: edit files
	````sh
			file content without merge problems.
	<<<<<<<
	this is the local version of the file content.
	|||||||
	this is the version of the common ancestor.
	=======
	this is the version of the remote commit.
	>>>>>>>
	````

## 

- **commit final version** of files as they were edited

	``` sh
			git add mergeFile1.txt
git add mergeFile2.csv
git commit -m "merge conflicts manually resolved"
	```

. . .

- **push** final local version to remote repository
	````sh
	git push origin master
	````

## Merging from remote

**pull** is shortcut for two separate steps:

. . .

- `git fetch`: **download** content

. . .

- `git merge`: **join** different versions

## Update unclean workspace

- if you need to update your repo from a remote, and do not want to
  commit temporary modifications:
	````
			git stash
	git pull origin master
	git stash apply
	````

# New repository

## set up git repo

- create and edit files

. . .

- `git init`

. . .

- `git commit -m "project started"`

. . .

- go to code hosting platform

. . .

- create new empty repository

. . .

- copy paste code to add remote repository and push to it

## add remote

- you can use multiple remote locations

. . .

- add remote
````
git remote add upstream https://github.com/user/gitRepo.git
````


## Contributing on github

- **fork repo**: own copy of repo in github

. . .

- **clone repo**: own local copy of repo

. . .

- add original repo location as **upstream** to stay up-to-date 

. . .

- edit and **commit**

. . .

- **pull** updates from original repo and **merge**

. . .

- **push** to own github copy 

. . .

- create **pull request**

# Commit history

## Hash keys

- each commit has a unique **hash** key, for example:
  *8b28faebc533eab693c61054d20b801f8e6245f4*

. . .

- this hash key can be used to refer to
	- previous **changes**
	- previous **repo states**


## history

- a commit contains a group of **modifications** and a **reference**
  to a previous commit

. . .

- **sum of commits**: successively applying changes on top of old
  changes **restores complete project**

. . .

- without referenced previous commit file changes associated with
  commit are useless

. . .

$\Rightarrow$ **messing with history** could make some commits useless


- non-linear commit history

## Go back in history

- **temporarily** recreate old state of repo
	````
	git checkout 4d3d2fd32
	````

. . .

- recreating old state with **editing** enabled: create new branch at
  old repo state
	````
	git checkout -b testingBranch 4d3d2fd32
	````

. . .

$\Rightarrow$ **modifications** in *testingBranch* can be **merged**
back into *master*

## Go back and change history

- **delete** everything up to some state in the past
	````
	git reset --hard 4d3d2fd32
	````

. . .

- modify and commit

. . .

**Be careful:**

If other people did build some changes on your history, you might
delete some old commits that are required by their work.

. . .

$\Rightarrow$ **Never mess with publicly available history** in order to
not break existing commit sequences.

## Experimenting

- create **checkpoint**: commit all modifications

. . .

- edit and save files, try new version

. . .

- if experiment fails: **discard** modifications by checking out the
  latest committed file version
````
git checkout filename.txt
````

# Advanced git

## git submodule

- proprietary data must remain outside of repository

. . .

- fix state of data: in ongoing analysis, which exact data was used
  when?

. . .

- keep evolving data in privately hosted repo 

. . .

- updating sub-directory requires manual pull for each submodule 

. . .

- submodule does not automatically ship with cloned repo

## git subtree

- example: embed re-usable libraries
- history of subtree can be omitted
- easy updating of external repositories
- see [Atlassian blog](http://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree/)

# Miscellaneous
  
## Additional software

- [myrepos](http://myrepos.branchable.com/)
- [GUI Clients](http://www.git-scm.com/downloads/guis)

## Further resources

- git lessons at [Software
  Carpentry](http://swcarpentry.github.io/git-novice/)
- [Atlassian tutorials](https://www.atlassian.com/git/tutorials/)
- [free git book](http://www.git-scm.com/book/en/v2)


## Alternatives

- [Apache Subversion](http://subversion.apache.org/)
- [Mercurial](http://swcarpentry.github.io/hg-novice/)


