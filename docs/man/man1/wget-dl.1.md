% WGET-DL(1)
% Jukka Svahn
% June 2026

# NAME

wget-dl -- Download files using wget

# SYNOPSIS

**wget-dl** [*command*] [*options*]

# DESCRIPTION

Download multiple files that require authentication or session cookies using
**wget**. Prompts for list of URLs, and allows sending login `POST` data that
contains `{u}` and `{p}` variables that  are substituted with prompted
*username* and *password*, hiding them from  terminal history. Received login
cookies are stored in `$WGET_COOKIES` file, which follow-up commands
will use to load cookies from.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`download` [*options*]
: Download multiple files. Prompts for list of URLs, which are saved into a
temporary **.wget-urls** file in the current working directory. If
**.wget-urls** file already exists, downloads are resumed from it.
Downloaded files are saved into the current working directory. Given options
are passed down to **wget**. This command is default, if **wget-dl** is called
without command argument.

`auth` [*options*]
: Prompt for username and password, and download prompted list of files using
basic HTTP authentication. Prompted list of download URLs are saved into a
temporary **.wget-urls** file in the current working directory. If
**.wget-urls** file already exists, downloads are resumed from it. Downloaded
files are saved into the current working directory. Given options are passed
down to **wget**.

`login` [*options*] `<`*url*[`?<`*post-data*`>`]`>`
: Establish a login session and store received cookies in `$WGET_COOKIES` file.
The optional *post-data* can contain `{u}` and `{p}` variables that are
replaced with prompted *username* and *password* respectively, if present. The
stored cookies are automatically loaded when downloading files with the
`download` or `auth` commands.

`logout`
: Resets `$WGET_COOKIES` file, removing all existing cookies, across all
domains.

`clear`
: Removes existing **.wget-urls** file, if one exists in the current working
directory. This clears the current download list, if it previously was
terminated before completing. This will then allow starting a new list of
downloads in the same current working directory, instead of resuming the
previous set of downloads.

# ENVIRONMENT

`WGET_COOKIES`
: Path to a file storing HTTP cookies. If not set, defaults to
`~/.wget-cookies`.

# FILES

Depends on external programs `awk`, `bash`, `cat`, `mktemp`, `nano`, `perl`
and `wget`.

# EXAMPLES

The following is the simplest use case; Prompts for URLs ands
starts downloading them to the current working directory:

    $ wget-dl

Logins to the site with a HTTP POST request, sending prompted username and
password as user and pass form fields, saving the received HTTP cookies
to the local `$WGET_COOKIES` file, from which download command will load
cookies from:

    $ wget-dl login "https://localhost.tld/login?user={u}&pass={p}"

The following downloads prompted URLs. Will use any existing login cookies,
if present:

    $ wget-dl download

Prompt for username and password, and try to download prompted URLs
while sending the username and password as HTTP Basic Authentication
headers:

    $ wget-dl auth
