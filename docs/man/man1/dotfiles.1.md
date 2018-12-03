% DOTFILES(1)
% Jukka Svahn
% October 2018

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

`install`
: Install dotfiles to the current user's home directory. Installation is done by
generating symbolic links and replacing `.bashrc`.

`build`
: Generate a singular, portable bash profile file.

# ENVIRONMENT

`DOTFILES_COLOR`
: Whether `TERM` says that it supports color.

`DOTFILES_DISPLAY`
: Whether `DISPLAY` is set.

`DOTFILES_HOME`
: Absolute path to dotfiles directory.

`DOTFILES_INTERACTIVE`
: Whether running in interactive shell.

`DOTFILES_PLATFORM`
: Name of the platform. Could be one of `solaris`, `macos`, `linux`, `freebsd`,
`bsd` or `win`.

# EXAMPLES

Navigate to `dotfiles` directory and install it:

    $ cd "path/to/dotfiles" && dotfiles install
