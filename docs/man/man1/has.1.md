% HAS(1)
% Jukka Svahn
% February 2019

# NAME

has -- List installed software versions

# SYNOPSIS

**has** [*options*] [*command* ...]

# DESCRIPTION

Checks and lists installed command versions.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-s`, `--supported`
: List supported commands.

`-u`, `--unsupported`
: List unsupported commands.

`-f`, `--force`
: Perform unsafe check even if the command is not supported.

*command*
: One or more command to check. If omitted, checks and lists all supported
commands.

# FILES

Depends on external programs `awk`, `bash`, `cat`, `column`, `grep` and `head`.

# EXAMPLES

Check and list all packages and their versions:

    $ has

Check `docker` and `git`:

    $ has docker git
