% CALC(1)
% Jukka Svahn
% October 2018

# NAME

calc -- Calculator

# SYNOPSIS

**calc** [*options*] [*calculation* ...]

# DESCRIPTION

Runs basic calculations using **bc** program.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

*calculation*
: One or more calculation to run. If omitted, uses `STDIN` or creates an
interactive prompt.

# FILES

Depends on external programs `bash`, `bc` and `cat`.

# EXAMPLES

Basic calculation as an argument:

    $ calc "2 + 3.5"

Pipe calculations:

    $ echo "2 / 6" | calc

Interactive prompt:

    $ calc
