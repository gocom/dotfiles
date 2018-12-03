% ALL(1)
% Jukka Svahn
% October 2018

# NAME

all -- Query Bash completion engine

# SYNOPSIS

**all** [*options*] [*command*]

# DESCRIPTION

List all available commands, tools and users as seen by Bash completion engine.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`commands`
: List commands.

`tools`
: List tools.

`users`
: List users.

# FILES

Depends on external programs `awk`, `bash`, `cat` `column`, `dirname` and
`sort`.

# EXAMPLES

Display all commands:

    $ all commands
