% APM-PKG(1)
% Jukka Svahn
% October 2018

# NAME

apm-pkg -- Atom.io package manager

# SYNOPSIS

**apm-pkg** [*options*] [*command*]

# DESCRIPTION

Manage Atom.io apm with `$ATOM_PACKAGES_FILE` manifest file, by default located
at `~/.atom/packages.txt`.

This wrapper extends **apm** with `install` and `dump` commands that allow
installing packages with a manifest file.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`dump` [*filename*]
: Dump list of installed packages to the manifest file.

`install` [*filename*]
: Install packages listed in the manifest file.

`list`
: List installed packages.

`lock`
: List installed packages and versions.

# ENVIRONMENT

`ATOM_PACKAGES_FILE`
: Path to the packages manifest file.

# FILES

Depends on external programs `apm`, `awk`, `bash`, `cat` and `sort`.

# EXAMPLES

Dump packages:

    $ apm-pkg dump

Install packages:

    $ apm-pkg install
