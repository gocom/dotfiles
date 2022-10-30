% DOTFILES(1)
% Jukka Svahn
% June 2022

# NAME

dotfiles -- Manage dotfiles

# SYNOPSIS

**dotfiles** [*options*] [*command*]

# DESCRIPTION

Install and manage dotfiles.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`docs` [*filename* ...]
: Generate documentation such as man pages.

`dump`
: Dump dependencies to lock files.

`install`
: Install dotfiles to the current user's home directory. Installation is done by
generating symbolic links and replacing `.bashrc`.

`install-packages`
: Install packages.

`lint`
: Lint codebase.

`prefix`
: Print dotfiles install path.

`pull`
: Pull dotfiles from remote.

`test`
: Run test suite.

`unit`
: Run unit tests.

`watch`
: Watch for file changes.

# ENVIRONMENT

`DOTFILES_HOME`
: Absolute path to dotfiles directory.

# EXAMPLES

Navigate to `dotfiles` directory and install it:

    $ cd "path/to/dotfiles" && dotfiles install

Self-update dotfiles if they were cloned using git:

    $ dotfiles pull
