if [ "$DOTFILES_DISPLAY" ]; then
  for i in "subl" "sublime-text.subl" "mate" "emacs" "gedit" "vim"; do
    i="$(command -v $i)"
    if [ -x "$i" ]; then
      export EDITOR="$i"
      export VISUAL="$i"
      break
    fi
  done
else
  for i in "nano" "pico" "vim" "vi"; do
    i="$(command -v $i)"
    if [ -x "$i" ]; then
      export EDITOR="$i"
      export VISUAL="$i"
      break
    fi
  done
fi
