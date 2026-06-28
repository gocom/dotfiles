% MAH(1)
% Jukka Svahn
% June 2026

# NAME

mah -- Rich man page viewer

# SYNOPSIS

**mah** [*options*] [*page* ...]

# DESCRIPTION

View man pages as HTML documents in a `$BROWSER`.

Generates HTML document from the specified manpage using **mandoc**, and opens
it using the configured `$BROWSER`. Generated pages are saved to `$MAH_HOME`
directory to avoid having to generate HTML document again for once accessed
manpage.

Generated HTML document can be styled with CSS by placing css file
to `$MAH_HOME/style.css`, defaulting to `~/.mah/style.css`, if
`MAH_HOME` is not set.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-f`, `--force`
: Overwrite cached page.

*page*
: Man page to view.

# ENVIRONMENT

`BROWSER`
: Web browser the HTML formatted man page is opened in. Standard `BROWSER`
environment variable, which should contain full command that can be used
to open a URL. The URL is passed to it as the first appended argument.

`MAH_HOME`
: Directory where **mah** stores generated and cached HTML pages,
and it's configuration options. If not set, defaults to
`~/.mah`.

# FILES

Depends on external programs `bash`, `basename`, `cat`, `dirname`,
`gunzip`, `man`, `mandoc` and `mkdir`.

# EXAMPLES

View man pages for `bash` and `test`:

    $ mah bash test
