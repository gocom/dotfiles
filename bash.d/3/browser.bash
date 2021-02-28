if [ "$DOTFILES_DISPLAY" ]; then
  if [ -x "$(command -v open)" ]; then
    export BROWSER="open"
  elif [ -x "$(command -v "chrome-cli")" ]; then
    export BROWSER="chrome-cli open"
  elif [ -x "$(command -v google-chrome)" ]; then
    export BROWSER="google-chrome"
  elif [ -x "$(command -v chromium-browser)" ]; then
    export BROWSER="chromium-browser"
  elif [ -x "$(command -v firefox)" ]; then
    export BROWSER="firefox"
  fi
fi

if ! [ "${BROWSER:-}" ] && [ -x "$(command -v links)" ]; then
  export BROWSER="links"
fi
