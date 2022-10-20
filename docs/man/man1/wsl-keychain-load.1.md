% WSL-KEYCHAIN-LOAD(1)
% Jukka Svahn
% October 2022

# NAME

wsl-keychain-load -- Store SSH key passphrases in Windows Credential Manager

# SYNOPSIS

**wsl-keychain-load** [*options*] `<`*filename*`>`

# DESCRIPTION

Loads SSH key passphrases from Windows Credential Manager to Keychain,
allowing SSH agent initialization on login without having to prompt
user for SSH key passphrases.

When **wsl-keychain-load** is executed from within WSL,
instead of prompting the user, **wsl-keychain-load** first looks for the
SSH key's record from Windows Credential Manager. If the credential
is not found from Windows-side, it will only then prompt for the passphrase.
After it has the passphrase, it adds the key to Keychain.

In Windows Credential Manager, SSH private key credentials' should be named
after the absolute WSL mount path to the key file as seen from Windows.
For example, if the SSH private key path is:

    /home/timmy/.ssh/id_rsa

The **Internet or network address** used in Credential Manager would be:

    wsl.localhost\Ubuntu\home\timmy\.ssh\id_rsa

If the used Distribution was Ubuntu. Within WSL, you can ask use `wslpath`
to help to translate Linux paths to Windows' paths.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

*filename*
: Path to SSH private key to be loaded. The given path should
be absolute path as seen from Linux, rather than Windows-side mount path.

# FILES

Depends on external programs `bash`, `cat`, `chmod`, `keychain`, `pwsh.exe`,
`rm`, `wslpath` and `wsl-credential-manager.ps1`.

Requires that `PowerShell` version >= 7 is installed in Windows, and
`CredentialManager` module to it. The module can be installed by
running in PowerShell:

    Install-Module -Name CredentialManager

# EXAMPLES

Loads user's `id_rsa` key in Keychain with passphrase from
Windows Credential Manager:

    $ wsl-keychain-load "$HOME/.ssh/id_rsa"
