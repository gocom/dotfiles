% CROP(1)
% Jukka Svahn
% October 2018

# NAME

Crop -- Crop an image

# SYNOPSIS

**crop** [*options*] [*file*] [*dimensions*] [*outfile*]

# DESCRIPTION

Scales and crops an image from the center.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# FILES

Depends on external programs `bash`, `cat` and `magick`.

# EXAMPLES

Crop `image.png` to a `320` by `180` pixels `thumbnail.png`:

    $ crop image.png 320x180 thumbnail.png
