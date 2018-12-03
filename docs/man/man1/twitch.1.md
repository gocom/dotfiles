% TWITCH(1)
% Jukka Svahn
% November 2018

# NAME

twitch -- Twitch.tv client

# SYNOPSIS

**twitch** [*options*] [*command*]

# DESCRIPTION

Check live followed Twitch.tv channels and watch broadcasts using
**streamlink**.

Configuration required for viewing your Twitch account's followed and live
channels is automatically prompted for when required, and then stored in
`~/.twitch`.

The program does not receive, or require, write or read access to your account,
but simply uses public-facing read-only API records.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`following`
: Lists followed channels.

`live`
: Lists followed live channels.

`open` `<`*channel*`>`
: Opens a channel page in `$BROWSER`.

`watch` `<`*channel*`>` [`<`*quality*`>` [*options*]]
: Opens a stream in a player using **streamlink**

# ENVIRONMENT

`BROWSER`
: The program channel page is opened in.

# FILES

Depends on external programs: `bash`, `cat`, `column`, `curl`, `date`, `jq`,
`mkdir`, `rm`, `streamlink` and `xargs`.

# EXAMPLES

List live channels:

    $ twitch live

Watch `faceittv`:

    $ twitch watch faceittv
