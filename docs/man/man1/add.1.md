% ADD(1)
% Jukka Svahn
% October 2018

# NAME

add -- Touch multiple files and directories

# SYNOPSIS

**add** [*options*] [*path* ...]

# DESCRIPTION

Recursively create multiple directories and files with a single command. Paths
ending with a directory separator character (`/`, `\`) will be treated as
directories and other paths as files.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-a`, `--all`
: Print list of created paths. This is the default. If used together with
`--open`, it will open all specified file paths.

`-i`, `--interactive`
: Interactive mode, where each path is prompted for.

`-l`, `--last`
: Print the last created path. If used together with `--open`, it will open the
last specified path.

`-o`, `--open`
: Open printed paths with external **open** command.

`-q`, `--quiet`
: Silent mode.

`-r`, `--relative`
: Each path is relative to the previous.

*path*
: List of filenames to touch. Paths ending with a slash are treated as
directories and other paths as files.

# ENVIRONMENT

`PWD`
: Is used to figure out the current working directory.

# FILES

Depends on external programs `bash`, `cat`, `dirname`, `mkdir`, `open`,
`realpath` and `touch`.

# EXAMPLES

Creates 3 directories, counting sub-directories, and 2 files:

    $ add example/readme.txt example/src/index.js example/test/

Creates `example` directory and 2 files into it:

    $ add -r example/ 1.txt 2.txt

Creates and opens `1.txt` and `2.txt`:

    $ add -o 1.txt 2.txt

Creates two files and opens the last one:

    $ add -lo 1.txt 2.txt

Piping a filename is also supported:

    $ echo "1.txt" | add

A list of paths can be read from a file:

    $ echo 1.txt >> filelist.txt
    $ echo 2.txt >> filelist.txt
    $ add < filelist.txt

Interactive mode allows creating multiple paths one by one:

    $ add -i
    ? Path:
