df::path --prepend "$HOME/bin" "$HOME/.local/bin" \
    "/usr/local/bin" "/usr/local/sbin" "/usr/local/games" \
    "/usr/bin" "/usr/sbin" "/usr/games" \
    "/bin" "/sbin" "/snap/bin"

df::path "$DOTFILES_HOME/bin" \
  "$DOTFILES_HOME/platform/$DOTFILES_PLATFORM/bin" \
  "/Applications/Firefox Developer Edition.app/Contents/MacOS" \
  "/Applications/Firefox.app/Contents/MacOS"
