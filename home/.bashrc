# Whether the session is interactive.
case "$-" in
  *i*) ;;
  *) return ;;
esac

if ! [ "${DOTFILES_HOME:-}" ]; then
  if [ -f "${XDG_CONFIG_HOME:-}/dotfiles/bashrc.d/bootstrap.bash" ]; then
    DOTFILES_HOME="$XDG_CONFIG_HOME/dotfiles"
  else
    DOTFILES_HOME=~/.dotfiles
  fi
fi

if [ "${DOTFILES_HOME:-}" ] && [ -f "$DOTFILES_HOME/bashrc.d/bootstrap.bash" ]; then
  . "$DOTFILES_HOME/bashrc.d/bootstrap.bash"
fi
