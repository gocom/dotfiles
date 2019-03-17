% DH(1)
% Jukka Svahn
% February 2019

# NAME

dh -- Docker Container Helpers

# SYNOPSIS

**dh** [*options*] [*command*]

# DESCRIPTION

Collection of Docker Container helper commands and shortcut aliases.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`ch` [*container*] `<`*command*`>`
: Run a command inside a container in the current working directory path. This
command can be used to mirror a local command from the host system in a
container that shares identical directory structure to the host system.

`names` [*container*]
: List container names.

`ids`
: List container IDs.

`ips`
: List container IP addresses.

`sh` [*container*]
: Launch shell session inside a container.

# ENVIRONMENT

`PWD`
: Is used to resolve local working directory path when mirroring a command.

# FILES

Depends on external programs `bash`, `cat`, `column`, `docker`, `head`,
`realpath` and `sed`.

# EXAMPLES

Start shell session in `php` container:

    $ dh sh php

Run `composer install` from within the `php` container:

    $ dh ch php composer install
