if grep -qi microsoft /proc/version; then
  export DOTFILES_WSL=1
else
  export DOTFILES_WSL=0
fi

if [ "$DOTFILES_WSL" -eq 1 ]; then
  # Tell Windows Terminal where the current working
  # directory is mounted in Windows, so that the correct
  # directory is open when a tab is duplicated.
  dotfiles_wsl_prompt_command () {
    printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
  }

  df::prompt_command_prepend dotfiles_wsl_prompt_command

  # Use keychain as a secret storage and SSH agent.
  if [ "$(command -v keychain)" ]; then
    for f in "$HOME/.ssh/id_"*; do
      if [ -f "$f" ] && [ -f "$f.pub" ]; then
        keychain -q --nogui "$f" 2> /dev/null
      fi
    done

    unset f

    if [ -f "$HOME/.keychain/$HOSTNAME-sh" ]; then
      . "$HOME/.keychain/$HOSTNAME-sh"
    fi
  fi

  # Forward GUI applications to X server running on Windows.
  export DISPLAY
  DISPLAY="$(ip route | grep default | awk '{print $3; exit;}'):0.0"
fi
