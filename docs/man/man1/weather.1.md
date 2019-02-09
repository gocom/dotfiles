% WGET-DL(1)
% Jukka Svahn
% October 2018

# NAME

weather -- Get weather report from wttr.in

# SYNOPSIS

**weather** [*options*] [*location* ...]

# DESCRIPTION

Downloads a weather report from wttr.in for the given locations. If no location
is given, tries to use your IP address to figure out your current location and
uses that instead.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-n`, `--now`
: Print current temperature instead of detailed forecast.

`location`
: One or more locations to get a weather report for. If not given, uses your
current location based on your public facing IP address.

# FILES

Depends on external programs `bash`, `cat`, `curl`, and `perl`.

# EXAMPLES

Get weather report for your current location:

    $ weather

Get weather report for `London` and `New York`:

    $ weather London "New York"
