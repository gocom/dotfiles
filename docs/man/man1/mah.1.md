% MAH(1)
% Jukka Svahn
% November 2018

# NAME

mah -- Rich man page viewer

# SYNOPSIS

**mah** [*options*] [*page* ...]

# DESCRIPTION

View man pages as HTML documents in a `$BROWSER`.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-f`, `--force`
: Overwrite cached page.

`-u`, `--uri`
: Open as `x-man-page` scheme.

*page*
: Man page to view.

# ENVIRONMENT

`BROWSER`
: Viewer the HTML formatted man page is opened in.

# FILES

Depends on external programs `bash`, `basename`, `cat`, `dirname`, `groff`,
`man`, `mandoc`, `mkdir` and `open`.

# EXAMPLES

View man pages for `bash` and `test`:

    $ mah bash test
