% PHP-DEBUG(1)
% Jukka Svahn
% February 2019

# NAME

php-debug -- Run PHP with different configurations

# SYNOPSIS

**php-debug** [*options*]

# DESCRIPTION

**php-debug** is a stub script that initializes PHP with a different set of
configuration files that are based on the filename of the executed binary.
Different configuration sets can be created by creating symbolic links to the
**php-debug** stub, and it will used configuration files named after the link.

For example, if the name of the linking symbolic link is `php-xdebug-server`
and `PHP_SYSCONFDIR` is `/etc/php/`, PHP configuration is loaded from, if it
exists:

    /etc/php/php-xdebug-server.ini

Extra config files are scanned from:

    /etc/php/xdebug-server.d/

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`--configs`
: List loaded extra configuration files.

`--init`
: Initialize new configuration set.

*php-options* ...
: Any other options are passed down to PHP.

# ENVIRONMENT

`PHP_INI_SCAN_DIR`
: Is used to set PHP's configuration scan directories.

# FILES

Depends on external programs `bash`, `cat` and `php`.

# EXAMPLES

Run `composer` project's `test` suite with `debug` configuration:

    $ php-debug /usr/local/bin/composer test
