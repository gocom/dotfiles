% WSL-VPNKIT(1)
% Jukka Svahn
% June 2024

# NAME

wsl-vpnkit -- Provide WSL2 network connectivity on a VPN

# SYNOPSIS

**wsl-vpnkit** [*options*] [*command*]

# DESCRIPTION

wsl-vpnkit is a tool that uses gvisor-tap-vsock to provide network connectivity
to the WSL 2 VM while connected to VPNs on the Windows host. This requires
no settings changes or admin privileges on the Windows host.

This command is wrapper around wsl-vpnkit toolkit, and offers a way to
automatically set up its dependencies. The command is designed for Ubuntu
and Debian, and should only be ran inside WSL 2 VM.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`install`
: Installs wsl-vpnkit tooling and dependencies.

`start`
: Starts wsl-vpnkit. This should be run after connecting to a VPN
in Windows. This will provide network connectivity inside the WSL VM OS
while the host Windows is connected to the VPN. To commend should be
kept running in an active shell session. Closing it will kill the
connection.

# ENVIRONMENT

`WSL_VNPKIT_HOME`
: Specifies a custom wsl-vpnkit installation directory. This can
be specified both during installation, and when starting wsl-vpnkit.

`WSL_VPNKIT_VERSION`
: Overrides wsl-vpnkit version that is downloaded during the installation.

`WSL_VPNKIT_CHECKSUM`
: Overrides wsl-vpnkit toolkit SHA-256 checksum that is downloaded during
the installation. If the download does not match the checksum, the
installation is aborted.

# FILES

Depends on external programs `apt-get`, `awk`, `cat`, `iptables`, `nslookup`,
`ping`, `tar`, `wget` and `wsl-gvproxy.exe`.

The `wsl-gvproxy.exe` comes as part of the wsl-vpnkit toolkit, which can be
installed by running:

    wsl-vpnkit install

# EXAMPLES

Installs wsl-vpnkit toolkit:

    $ wsl-vpnkit install

Starts wsl-vpnkit:

    $ wsl-vpnkit start
