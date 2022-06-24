df::path "$DOTFILES_HOME/packages/"*"/bin"

df::path -n "manpath" "$DOTFILES_HOME/packages/"*"/man"

if [ "$(declare -F _init_completion)" ]; then
  for file in "$DOTFILES_HOME/packages/"*"/extra/bash_completion.d/"*; do
    if [ -f "$file" ]; then
      . "$file"
    fi
  done

  unset file
fi
