% WGET-DL(1)
% Jukka Svahn
% June 2026

# NAME

wget-dl -- Download files

# SYNOPSIS

**wget-dl** [*command*] [*options*]

# DESCRIPTION

Download files that require authentication or session cookies using **wget**.
Allows sending login `POST` data that contains `{u}` and `{p}` variables that
are substituted with prompted *username* and *password*, hiding them from
terminal history. Received login cookies are stored in `$WGET_COOKIES`, or
`~/.wget-cookies`.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`auth` [*options*]
: Prompt for username and password, download a file using basic HTTP
authentication.

`download` [*options*]
: Download a file, using any previously established login cookies.

`login` [*options*] `<`*url*[`?<`*post-data*`>`]`>`
: Establish a login session and store cookies in `$WGET_COOKIES` file. The
optional *post-data* can contain `{u}` and `{p}` variables that are replaced
with prompted *username* and *password* respectively, if present.

# ENVIRONMENT

`WGET_COOKIES`
: Path to a file storing HTTP cookies.

# FILES

Depends on external programs `bash`, `cat`, `nano`, `perl` and `wget`.

# EXAMPLES

Log-in to `example.test` by sending `user` and `pass` HTTP POST parameters
containing prompted username `{u}` and password `{p}`:

    $ wget-dl login "https://example.test/login?user={u}&pass={p}"

Prompts for download URLs. Downloads them using any previously established
login cookies:

    $ wget-dl download

Download file protected by basic HTTP authentication:

    $ wget-dl auth
