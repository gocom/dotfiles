% BOOKMARK(1)
% Jukka Svahn
% October 2018

# NAME

bookmark -- Bookmark files and URLs

# SYNOPSIS

**bookmark** [*options*] [*command*] [[[*path*] [*url*]] [*name*]]

# DESCRIPTION

Bookmarks URLs, files and directories. Symbolic filesystem links are created to
`$LINKS` or `~/Links`, and URL shortcuts to `$BOOKMARKS` or `~/Bookmarks`.

These can then be accessed through file manager, **bookmark** command-line
interface or integrated with `$CDPATH`.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-o`, `--open`
: Open matching printed URLs or linked files using **open** command, or `$BROWSER`.

`-n`, `--name`
: List matching names, rather than columns.

`-t`, `--target`
: List matching target paths and URLs, rather than columns.

`-k` `<`*keyword*`>`, `--keyword`[=]`<`*keyword*`>`
: Substitute `%s` in an URL or a path with the given keyword.

# COMMANDS

`file` [[*path*] [*name*]]
: Bookmark a file.

`files` [*name*]
: List matching linked files.

`list` [*name*]
: List matching linked files and URLs.

`open` [*name*]
: Open matching linked files with **open** program and URLs in `$BROWSER`.

`url` [[*url*] [*name*]]
: Bookmark an URL.

`urls` [*name*]
: List matching bookmarked URLs.

# ENVIRONMENT

`BOOKMARKS`
: Path to a directory where `.url` shortcuts are stored.

`BROWSER`
: If available, is used for opening URLs with `--open` option.

`HOME`
: Used for finding default storage locations for bookmarked items.

`LINKS`
: Path to a directory where symbolic links are stored. This directory can be
used with `CDPATH`.

`PWD`
: Used as the current directory location when the `path` is omitted.

# FILES

Depends on external programs `awk`, `basename`, `head`, `mkdir`, `open`, `perl`
and `sed`.

# EXAMPLES

Bookmark an URL:

    $ bookmark https://example.com
    > /home/user/Bookmarks/example.com.url

Bookmark a file:

    $ bookmark filename.txt
    > /Users/jukka/Links/filename.txt

Bookmark directory path as `myproject`:

    $ bookmark file /path/to/myproject/src myproject
    > /Users/jukka/Links/myproject

Bookmark `https://example.com` as `blog`:

    $ bookmark url example.com blog
    > /Users/jukka/Bookmarks/blog.url

Bookmark the current working directory:

    $ cd "path/to/directory" && bookmark
    > /Users/jukka/Links/directory

Prompt for an URL:

    $ bookmark url
    ? URL:
    ? Name:

List bookmarks that contain `example` in their name:

    $ bookmark list "example"
    > example               /path/to/projects/example
    > example.test          https://example.test

Open bookmarks that contain `example` in their name:

    $ bookmark open "example"
    > Opening /home/projects/example/
    > Opening https://example.test

Bookmark Google search result page with a keyword substitution:

    $ bookmark "https://www.google.com/search?q=%s"
    > /home/user/Bookmarks/www.google.com.url

And search using it with the `--keyword` option:

    $ bookmark open google --keyword test
