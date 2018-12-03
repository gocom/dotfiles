% YOUTUBE-DLA(1)
% Jukka Svahn
% November 2018

# NAME

youtube-dla -- Download YouTube audio

# SYNOPSIS

**youtube-dla** [*options*] `<`*url*`>`

# DESCRIPTION

Download YouTube audio stream as AAC in a m4a container using **youtube-dl**.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# FILES

Depends on external programs `bash`, `cat` and `youtube-dl`.

# EXAMPLES

Save downloaded audio as `null.m4a`:

    $ youtube-dla "https://youtube.com/watch?v=null"
