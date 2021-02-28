df::path --prepend "$HOME/bin" "$HOME/.local/bin" \
    "/usr/local/bin" "/usr/local/sbin" "/usr/local/games" \
    "$DOTFILES_HOME/platform/$DOTFILES_PLATFORM/bin" \
    "$DOTFILES_HOME/bin" \
    "/usr/bin" "/usr/sbin" "/usr/games" \
    "/bin" "/sbin" "/snap/bin"

df::path "/Applications/Firefox Developer Edition.app/Contents/MacOS" \
  "/Applications/Firefox.app/Contents/MacOS"
