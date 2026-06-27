% WSL-PROVISION(1)
% Jukka Svahn
% June 2026

# NAME

wsl-provision -- Provision new Ubuntu based WSL image

# SYNOPSIS

**wsl-provision** [*options*]

# DESCRIPTION

Runs similar provision steps as Windows Store does. This can be used when
installing custom WSL distribution. This command should be run as root
within a WSL image to provision it.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# ENVIRONMENT

`DEFAULT_TIMEZONE`
: Specifies default set up timezone, which is used, if the user does not
provide timezone when prompted. Defaults to `Europe/Helsinki`.

`DEFAULT_LOCALE`
: Specifies default set up locale, which is used, if the user does not
provide locale when prompted. Defaults to `en_GB.UTF-8`.

# FILES

Depends on external programs `adduser` `apt-get` `bash` `cat` `ln` `locale-gen`
`update-locale` `usermod`.

# EXAMPLES

Provisions the current image:

    $ wsl-provision
