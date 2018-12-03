if ! [ "$(declare -F __git_ps1)" ]; then
  if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
  fi
fi

if [ "$(declare -F __git_ps1)" ]; then
  prompt_git_callback () {
    local branch="$(GIT_PS1_SHOWDIRTYSTATE=yes; __git_ps1 "%s")"

    if [ "$branch" ]; then
      df::prompt_append 5 "${PS_MAGENTA}⎇${PS_RESET} ${PS_BLUE}${branch}${PS_RESET}"
    fi
  }

  df::prompt_handler 'prompt_git_callback'
fi
