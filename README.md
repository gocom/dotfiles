.dotfiles
=====

Personal [Bash](https://www.gnu.org/software/bash/) shell configuration files
and scripts.

Supported OS
-----

* Ubuntu 20.04 LTS
* Ubuntu 20.04 LTS in WSL2
* Ubuntu 22.04 LTS
* Mac OS 10.15

Install
-----

It is expected that dotfiles are accessible through `~/.dotfiles`, either by
a link or otherwise. Clone the repository to that location and run the
installer, which creates symbolic links to your home directory:

```shell
$ git clone https://github.com/gocom/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
$ make install
```

The above requires Docker and docker-compose. Docker is used for building man
pages and other assets, without placing hard requirements on the host
system.

If you do not require man pages or other assets, and just want to symlink
dotfiles to your home directory, you can run:

```shell
$ make link
```

The above avoids Docker requirement and all actions are
performed on the host system.

Requirements
-----

Dotfiles require:

* [Bash](https://www.gnu.org/software/bash/) >= 4.3
* [Coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* perl
* GNU awk

Building and installing requires:

* GNU make
* Docker
* docker-compose

Optional setup
-----

The repository also contains set of tools that can be installed with various
package managers:

```
$ brew install
$ bundle install
$ composer install
```

Customizing Bash configuration
-----

Local Bash configuration can be customized from `~/.bash_login`,
`~/.bash_aliases` and `~/.bash_config` files.  If one of these exists, it is
included in the login shell bashrc and never  overwritten by the installer.

```
echo 'export EDITOR=/usr/local/bin/atom' >> ~/.bash_config
```

Configuring git
-----

Local git config can be provided with `~/.gitconfig_local`.

```
git config --file ~/.gitconfig_local user.email foobar@example.tld
git config --file ~/.gitconfig_local user.name "Foo Bar"
```
