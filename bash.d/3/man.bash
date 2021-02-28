export MANWIDTH=80
df::path -n "manpath" "/usr/share/man" "/usr/local/share/man" \
  "$DOTFILES_HOME/share/man" \
  "$DOTFILES_HOME/platform/$DOTFILES_PLATFORM/share/man"
df::path -n "infopath" "/usr/share/info" "/usr/local/share/info"
