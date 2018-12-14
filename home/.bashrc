# Whether the session is interactive.
case "$-" in
  *i*) ;;
  *) return ;;
esac

export DOTFILES_HOME="${DOTFILES_HOME:-}"
export DOTFILES_COLOR=""
export DOTFILES_INTERACTIVE=1
export DOTFILES_PLATFORM="${OSTYPE:-}"
export DOTFILES_DISPLAY=""

if ! [ "$DOTFILES_HOME" ]; then
  if [ "${XDG_CONFIG_HOME:-}" ]; then
    DOTFILES_HOME="$XDG_CONFIG_HOME/dotfiles"
  else
    DOTFILES_HOME="$HOME/.dotfiles"
  fi
fi

# Exit using CTRL+D requires confirmation.
IGNOREEOF=1

# Check window size on prompt and update columns if needed.
shopt -s checkwinsize

# If not running interactively, don't do anything
# [ "${PS1:-}" ] && return

# Lesspipe.
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Figure out whether the terminal supports color or not.
case "$TERM" in
  xterm-color|*-256color) DOTFILES_COLOR=1 ;;
  dumb) DOTFILES_COLOR="" ;;
  *)
    if [ "$(command -v tput)" ] && tput setaf 1 >&/dev/null; then
      DOTFILES_COLOR=1
    fi
    ;;
esac

case "$DOTFILES_PLATFORM" in
  solaris*)      DOTFILES_PLATFORM="solaris" ;;
  darwin*)       DOTFILES_PLATFORM="macos" ;;
  linux*)        DOTFILES_PLATFORM="linux" ;;
  freebsd*)      DOTFILES_PLATFORM="freebsd" ;;
  bsd*)          DOTFILES_PLATFORM="bsd" ;;
  msys*|cygwin*) DOTFILES_PLATFORM="win" ;;
esac

# Whether display is set.
if [ "$DISPLAY" ]; then
  DOTFILES_DISPLAY=1
fi

for file in "$DOTFILES_HOME"/lib/core/*.bash; do
  if [ -f "$file" ]; then
    . "$file"
  fi
done

for file in "$DOTFILES_HOME"/lib/module/*/*.bash; do
  if [ -f "$file" ]; then
    . "$file"
  fi
done

unset file

if [ -f ~/.bash_login ]; then
  . ~/.bash_login
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_config ]; then
  . ~/.bash_config
fi
