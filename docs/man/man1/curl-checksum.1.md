% CURL-CHECKSUM(1)
% Jukka Svahn
% October 2018

# NAME

cURL-checksum -- Checksum-validate received response

# SYNOPSIS

**curl-checksum** [*options*] [*url*] [*checksum*] [*curl-options*]

# DESCRIPTION

Download a file and validate it's contents against the given SHA-256 checksum
hash. If the content matches the checksum, output the contents to `STDOUT`,
otherwise exit with an error code 1.

If no **checksum** argument is given, a generated checksum will be printed to
`STDOUT` instead of the file contents.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

*url*
: Resource to download and print to `STDOUT`.

*checksum*
: SHA-256 checksum to validate the file against.

*curl-options*
: Options that are passed down to **cURL**.

# FILES

Depends on external programs `awk`, `bash`, `cat`, `curl` and `shasum`.

# EXAMPLES

Download a `file.zip`, validate it against a checksum and save it as `a.zip`:

    $ curl-checksum https://localhost/file.zip ecf701f727d9e2d77c4aa49ac6fbbcc997278aca010bddeeb961c10cf54d435a > a.zip

Generate a new checksum:

    $ curl-checksum https://localhost/file.zip
    > ecf701f727d9e2d77c4aa49ac6fbbcc997278aca010bddeeb961c10cf54d435a
