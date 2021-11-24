% IPV6-CONFIG(1)
% Jukka Svahn
% April 2021

# NAME

ipv6-config -- Manage IPv6 configuration

# SYNOPSIS

**ipv6-config** [*options*] [*command*]

# DESCRIPTION

Disable or enable IPv6 support on the fly using sysctl.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`disable`
: Disables IPv6 support.

`enable`
: Enables IPv6 support.

`info`
: Shows current status.

# FILES

Depends on external program `sysctl`.

# EXAMPLES

Disable IPv6 support:

    $ ipv6-config disable

Enable IPv6 support:

    $ ipv6-config enable
