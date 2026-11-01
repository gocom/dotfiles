% GPG-HELPER(1)
% Jukka Svahn
% November 2026

# NAME

gpg-helper -- GPG key helper

# SYNOPSIS

**wget-dl** [*command*] [*options*]

# DESCRIPTION

Contains helper tasks for managing GPG keys.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`edit` `<`*email*`>`
: Edits the specified GPG key. Open interactive shell that can be, for
instance, be used to set the trust level of the key.

`export` `<`*email*`>`
: Exports the GPG key for the given email to the current work directory.
Expects that the current working directory does not contain
`public-gpg.key`, `secret-gpg.key` or `ownertrust-gpg.txt` named
files.

`import` `<`*email*`>`
: Imports secret-gpg.key and `ownertrust-gpg.txt` files from the current
working directory.

`list` `<`*email*`>`
: Lists available GPG secret keys for the specified email address.

`reload`
: Reloads GPG agent. This can be used to restart the agent after
configuration changes, or if the agent is having issues.

`trust` `<`*email*`>`
: Try to trust the specified GPG key ultimately.

# FILES

Depends on external programs `bash`, `gpg`, `gpgconf` and `sed`.

# EXAMPLES

The following lists available GPG keys for `john.doe@example.tld`:

    $ gpg-helper list john.doe@example.tld
