.dotfiles
=====

Personal [Bash](https://www.gnu.org/software/bash/) shell configuration files and scripts.

Supported OS
-----

* Ubuntu 18.04 LTS
* Ubuntu 20.04 LTS
* Mac OS 10.15

Install
-----

It is expected that dotfiles are accessible through `~/.dotfiles`, either by a link or otherwise.
Clone the repository to that location and run the installer:

```
$ git clone https://github.com/gocom/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
$ make install
```

Requirements
-----

* [Bash](https://www.gnu.org/software/bash/) >= 4.3
* [Coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* perl
* GNU awk

Optional setup
-----

The repository also contains set of tools that can be installed with various package managers:

```
$ brew install
$ bundle install
$ composer install
$ npm install
```

Customizing Bash configuration
-----

Local Bash configuration can be customized from `~/.bash_login`, `~/.bash_aliases` and `~/.bash_config` files.
If one of these exists, it is included in the login shell bashrc and never overwritten by the installer.

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
