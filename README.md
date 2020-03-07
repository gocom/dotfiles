.dotfiles
=====

Personal [Bash](https://www.gnu.org/software/bash/) shell configuration files and scripts.

Install
-----

The scripts expect that they can be accessed from `~/.dotfiles`. Clone the repository to that location and source the configuration files from `home` directory in your `.bash_profile` and `.bashrc`.

```
$ git clone https://github.com/gocom/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/bin/dotfiles install
```

Requirements
-----

* [Bash](https://www.gnu.org/software/bash/) >= 4.3
* [Coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* perl
* GNU awk

Setup
-----

The repository also contains set of tools that can be installed with various package managers:

```
$ brew install
$ composer install
$ npm install
$ apm-pkg install
```

Customizing Bash configuration
-----

Local Bash configuration can be customized from `~/.bash_login`, `~/.bash_aliases` and `~/.bash_config` files. If one of these exists, it is included in the login shell bashrc and never overwritten by the installer.

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
