case "$-" in
  *i*) export DOTFILES_INTERACTIVE=1 ;;
  *) export DOTFILES_INTERACTIVE=0 ;;
esac

export DOTFILES_HOME="${DOTFILES_HOME:-}"
export DOTFILES_COLOR=""
export DOTFILES_PLATFORM="${OSTYPE:-}"
export DOTFILES_DISPLAY=""

if ! [ "$DOTFILES_HOME" ]; then
  DOTFILES_HOME="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
fi

# Exit using CTRL+D requires confirmation.
IGNOREEOF=1

# Check window size on prompt and update columns if needed.
shopt -s checkwinsize

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
  solaris*) DOTFILES_PLATFORM="solaris" ;;
  darwin*) DOTFILES_PLATFORM="macos" ;;
  linux*) DOTFILES_PLATFORM="linux" ;;
  freebsd*) DOTFILES_PLATFORM="freebsd" ;;
  bsd*) DOTFILES_PLATFORM="bsd" ;;
  msys*|cygwin*) DOTFILES_PLATFORM="win" ;;
esac

# Whether display is set.
if [ "$DISPLAY" ]; then
  DOTFILES_DISPLAY=1
fi

for file in "$DOTFILES_HOME"/bashrc.d/*/*.bash; do
  if [ -f "$file" ]; then
    # shellcheck source=/dev/null
    . "$file"
  fi
done

unset file

if [ -f ~/.bash_login ]; then
  # shellcheck source=/dev/null
  . ~/.bash_login
fi

if [ -f ~/.bash_aliases ]; then
  # shellcheck source=/dev/null
  . ~/.bash_aliases
fi

if [ -f ~/.bash_config ]; then
  # shellcheck source=/dev/null
  . ~/.bash_config
fi
