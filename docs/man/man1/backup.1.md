% BACKUP(1)
% Jukka Svahn
% October 2018

# NAME

backup -- Backup directories and volumes

# SYNOPSIS

**backup** [*options*] `<`*source* ...`>` `<`*destination*`>`

# DESCRIPTION

Files are backed up using **rsync** from the specified *source* directories to
under the *destination* directory.

Specified *source* directory is skipped if it is not readable, or contains
a `.rsync-exclude` file.

Some hidden operating system related files are automatically excluded from the
root of the *source* directory, including `.Trashes`, `lost+found`, temporary
files and spotlight indexes.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-D`, `--dry-run`
: Dry-run without writing anything.

`-q`, `--quiet`
: Silent mode.

`-R` `<`*days*`>`, `--rotate`[=]`<`*days*`>`
: Snapshots older than in *days* are deleted. If `0`, disables rotation.

`-r`, `--remote`
: Remote mode, drop functionalities that only function locally.

`-s`, `--snapshot`
: Create incremental snapshot similarly to macOS Time Machine.

`-V`, `--verbose`
: Verbose mode.

*source*
: One or more directory paths to back up. If omitted, sources are read from
`STDIN` instead.

*destination*
: Path to location where the backups are stored. If *source* and *destination*
are both omitted, the last line from `STDIN` is used as the *destination*.

# ENVIRONMENT

`PWD`
: Used to resolve current working directory.

# FILES

Depends on external programs `bash`, `cat`, `find`, `mkdir`, `realpath` and
`rsync`.

# EXAMPLES

Back-up current user directories from `/home` and volumes from `/mnt` to
`/mnt/backups`:

    $ backup /home/* /mnt/* /mnt/backups

Because non-existing locations are ignored, universal set of paths can be used
and deployed on various host systems:

    $ backup /home/* /Users/* /mnt/* /media/*/* /Volumes/* /mnt/backups

Paths can be piped:

    $ echo /mnt/source | backup /mnt/backups

And read from a file, `list.txt`, containing list of paths:

    $ echo /mnt/1 >> list.txt
    $ echo /mnt/2 >> list.txt
    $ backup /mnt/backups < list.txt
