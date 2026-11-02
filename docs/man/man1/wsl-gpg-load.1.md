% WSL-GPG-LOAD(1)
% Jukka Svahn
% November 2026

# NAME

wsl-gpg-load -- Store GPG key passphrases in Windows Credential Manager

# SYNOPSIS

**wsl-gpg-load** [*command*] [*options*]

# DESCRIPTION

Loads GPG key passphrases from Windows Credential Manager to GPG agent,
allowing GPG agent initialization on login without having to prompt
user for GPG key passphrases.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`init`
: Loads all GPG key passphrases.

`load` `<`*email*`>`
: Loads the passphrase for the specified GPG secret key.

`save` `<`*email*`>`
: Prompts and saves the passphrase for the given GPG secret key to Windows
Credential Manager.

# FILES

Depends on external programs `bash`, `cat`, `gpg-helper`, `gpg-preset-passphrase`, `pwsh.exe`,
`wsl-credential-manager-add.ps1` and `wsl-credential-manager-read.ps1`.

Requires that `PowerShell` version >= 7 is installed in Windows, and
`TUN.CredentialManager` module is installed to it. The module can
be installed by running the following in PowerShell:

    Install-Module -Name TUN.CredentialManager

# EXAMPLES

Loads the `joe.does@example.tld ` key passphrase from Windows Credential
Manager:

    $ wsl-gpg-load joe.does@example.tld

Saves `joe.does@example.tld` key's passphrase to  Windows Credential Manager:

    $ wsl-gpg-load save joe.does@example.tld
