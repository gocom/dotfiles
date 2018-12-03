% PROJECT(1)
% Jukka Svahn
% October 2018

# NAME

project -- Initialize a project directory from a template

# SYNOPSIS

**project** [*options*]

# DESCRIPTION

Creates a new project directory from a template skeleton directory. The program
should be run in an empty directory that should host a new project and answer
the prompted questions.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

`-F`, `--force`
: Allow overwriting existing files.

`-q`, `--quiet`
: Non-interactive mode, does not prompt for answers, but instead either uses
defaults or given as options.

`-V`, `-VV`, `--verbose`
: Verbose mode. The more short `V` flags are used, the higher the verbosity
level is raised.

`-D`, `--dry-run`
: Dry-run without writing anything.

`--no-color`
: Disable colors.

`--color`
: Enable colors.

`-l`, `--templates`
: List available project template identifiers.

`-L`, `--licenses`
: List available license identifiers.

# TEMPLATES

Template skeletons are stored in `PROJECT_TEMPLATE`, or `~/.projects`, directory,
from where they are read and then constructed using variables. Variables are
populated using interactive prompts, or from options given when the program was
ran. Some values, such as author information, can be also collected from
external sources such as from **git**.

The `PROJECT_TEMPLATE` directory should have the structure of:

```
$PROJECT_TEMPLATE/
  license/
    header/
      $license.license
    $license.license
template/
  $template/
    root/
    config.json
```

# ENVIRONMENT

`NO_COLOR`
: Disables color output.

`PROJECT_TEMPLATE`
: Path to directory where template skeletons are stored. Defaults to
`~/.projects` if not set.

# FILES

Depends on external programs: `node`, `git`

# EXAMPLES

Create a new directory `test` and initialize project template in it:

    $ mkdir test && cd test
    $ project
