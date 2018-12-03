% DD-CLONE(1)
% Jukka Svahn
% October 2018

# NAME

dd-clone -- Clone a disk

# SYNOPSIS

**dd-clone** [*options*] [*source*] [*target*]

# DESCRIPTION

Clones a disk with sane defaults using **dd**.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

*source*
: Source disk device index number.

*target*
: Target disk device index number.

# EXAMPLES

Clones `/dev/disk0` to `/dev/disk1`:

    $ dd-clone 0 1
