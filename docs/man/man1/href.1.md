% HREF(1)
% Jukka Svahn
% November 2018

# NAME

href -- Extract URLs

# SYNOPSIS

**href** [*options*] [*filename* ...]

# DESCRIPTION

Extract fully-qualified link targets from a well-behaved HTML document. This
can be used to parse bookmark files or pick URLs from HTML pages.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-u`, `--urls`
: List URLs.

`-d`, `--domains`
: List hostnames.

`-i`, `--insecure`
: List URLs that do not use HTTPS.

*filename*
: One or more filename to process. If omitted, `STDIN` is used instead.

# FILES

Depends on external programs `awk`, `bash`, `cat`, `grep` and `lynx`.

# EXAMPLES

Extract URLs from `bookmarks.html`:

    $ href bookmarks.html

Get unique domains from `bookmarks.html`:

    $ href -d bookmarks.html

Pipe a `1.html` and save results as `2.txt`:

    $ href < 1.html > 2.txt
