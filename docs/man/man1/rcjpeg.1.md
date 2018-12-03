% RCJPEG(1)
% Jukka Svahn
% October 2018

# NAME

rcjpeg -- Compress images

# DESCRIPTION

Compress list of images files of various image formats using **ImageMagick** and
**MozJpeg**. Processed files are saved to the specified target directory,
mirroring the original relative directory layout as seen from the current
working directory.

# SYNOPSIS

**rcjpeg** [*options*] [*filename* ...]

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-D`, `--dry-run`
: Dry-run without writing.

`-F`, `--force`
: Allow overwriting existing files.

`-S`, `--silent`
: Silent mode, do not log to `STDOUT`.

`-V`, `--verbose`
: Verbose mode.

`--color`, `--no-color`
: Enable or disable color output. Colors are also disabled if `NO_COLORS`
environment variable is set, or the command is run from `TERM=dump`.

`-d` `<`*path*`>`, `--directory`[=]`<`*path*`>`
: Directory to write processed files, defaults to `'compressed'`.

`-e` `<`*ext*`>`, `--extension`[=]`<`*ext*`>`
: Output extension, defaults to `'.jpg'`.

`-o` `<`*path*`>`, `--out`[=]`<`*path*`>`, `--outfile`[=]`<`*path*`>`
: Output file to write the processed data. If ends to a slash, is treated
as a directory, overriding  `--directory`.

`-q` `<`*integer*`>`, `--quality`[=]`<`*integer*`>`
: Compression quality 0 - 100, defaults to `'80'`

*filename*
: One or more image files to process. If omitted, `STDIN` is used instead.

# ENVIRONMENT

`NO_COLOR`, `TERM=dumb`
: If set, color output is disabled.

`PWD`
: Is used to figure out the current working directory tree structure.

# FILES

Depends on external programs `bash`, `cat`, `cjpeg`, `magick`, `mkdir`, `mv`
and `rm`.

`mozjpeg`
: Must be placed to `PATH` as `mozjpeg` or as a `cjpeg`.

# EXAMPLES

Compress any applicable files in the current directory:

    $ rcjpeg *

Compress `file.png` from `STDIN` and write compressed file to `output.jpg`:

    $ rcjpeg < file.png > output.jpg

Compress `.jpg` files in the `images` directory with compression quality of
`90`, and write the results to `dist`:

    $ rcjpeg -d dist -q 90 images/*.jpg
