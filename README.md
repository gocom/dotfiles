.dotfiles
=====

Personal [Bash](https://www.gnu.org/software/bash/) shell configuration files and scripts.

Install
-----

The scripts expect that they can be accessed from `~/.dotfiles`. Clone the directory to that location and source the configuration files in `.bash_profile` and `.bashrc`.

```
$ git clone git@github.com:gocom/dotfiles.git ~/.dotfiles
$ ./.dotfiles/bin/dotfiles install
```

Requirements
-----

* [Bash](https://www.gnu.org/software/bash/) >= 4.3
* [Coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* perl
* GNU awk

Setup
-----

The repository also contains set of tools that can be installed with various package managers:

```
$ brew install
$ composer install
$ npm install
$ apm-pkg install
```
