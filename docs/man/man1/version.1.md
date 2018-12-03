% VERSION(1)
% Jukka Svahn
% October 2018

# NAME

version -- Print a version number for a project directory

# DESCRIPTION

Print a version number for the specified project directory. The version number
is extracted from any found package manifest file such as `composer.json`,
`package.json`, or a most recent tag from **git** repository.

# SYNOPSIS

**version** [*options*]

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# ENVIRONMENT

`PWD`
: Is used to figure out the current working directory tree structure.

# FILES

Depends on external programs `bash`, `cat`, `git` and `jq`.

# EXAMPLES

Print version number for the `project` directory:

    $ cd path/to/project
    $ version
