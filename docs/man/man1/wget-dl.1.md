% WGET-DL(1)
% Jukka Svahn
% October 2018

# NAME

wget-dl -- Download login protected files

# SYNOPSIS

**wget-dl** [*options*] [*command*] `<`*url*`>`

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

`auth` [*options*] `<`*url*`>`
: Prompt for username and password, download a file using basic HTTP
authentication.

`download` [*options*] `<`*url*`>`
: Download a file, using any previously established login cookies.

`login` [*options*] `<`*url*[`?<`*post-data*`>`]`>`
: Establish a login session and store cookies in `$WGET_COOKIES` file. The
optional *post-data* can contain `{u}` and `{p}` variables that are replaced
with prompted *username* and *password* respectively, if present.

# ENVIRONMENT

`WGET_COOKIES`
: Path to a file storing HTTP cookies.

# FILES

Depends on external programs `bash`, `cat`, `perl` and `wget`.

# EXAMPLES

Log-in to `example.test` by sending `user` and `pass` HTTP POST parameters
containing prompted username `{u}` and password `{p}`:

    $ wget-dl login "https://example.test/login?user={u}&pass={p}"

Download item `3451` from `example.test`, using any previously established login
cookies:

    $ wget-dl download "https://example.test/download/3451"

Download `file.zip` protected by basic HTTP authentication:

    $ wget-dl auth "https://example.test/file.zip"
