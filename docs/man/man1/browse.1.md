% BROWSE(1)
% Jukka Svahn
% October 2018

# NAME

Browse -- Open a file or an URL in a browser

# SYNOPSIS

**browse** [*options*] [*url*]

# DESCRIPTION

Open a file or an URL in a `$BROWSER`. To use the program, the `$BROWSER`
environment variable must be set in your profile, and point to a valid browser
program. Good options might be `open`, or a specific web browser:

```
export BROWSER="open"
export BROWSER="firefox --new-tab"
export BROWSER="google-chrome"
```

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

*url*
: Resource to open.
: - If `-`, the URL is read from `STDIN`.
: - If `?`, the URL is prompted for.
: - If omitted, opens the current working directory.
: - If starts with `.` or `/`, is resolved as a local `file`.
: - If scheme is omitted, `https` is used.

# ENVIRONMENT

`BROWSER`
: Sets the used browser program.

`PWD`
: Used for resolving local URLs relative to the current working directory.

# FILES

Depends on external programs `bash`, `cat`, `dirname` and `realpath`.

# EXAMPLES

Open an URL:

    $ browse https://example.com
    $ browse example.com

Open the `example` directory:

    $ cd path/to/example && browse

Open a local `file.html`:

    $ browse ./file.html

From stdin:

    $ echo "https://example.com" | browse -

Prompt for an URL:

    $ browse ?
    ? URL:
