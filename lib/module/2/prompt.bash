
dotfiles_prompt () {
  df::color -e

  if ! [ "${PS_PREVIOUS_PWD:-$HOME}" = "$PWD" ]; then
    df::prompt_add 3 "${yellow}↠${reset} ${green}${PWD}${reset}\n"
  fi

  df::prompt_add 5 "${PS_BOLD}${blue}\u${reset}"
  df::prompt_add 5 "${magenta}@${reset}"
  df::prompt_add 5 "${PS_BOLD}${blue}\h${reset}"

  if [ "$UID" -eq 0 ]; then
    df::prompt_append "m" "${red}${PS_TOXIC}${reset}"
  else
    df::prompt_append "m" "${PS_BOLD}${magenta}${PS_COMMAND}${reset}"
  fi

  df::prompt_add "e0" "$TERM"
  df::prompt_add "e1" "${PWD##*/}"
  df::prompt_add "e2" "$PWD – ${0##*/}"
  df::prompt_status || df::prompt_add w "${yellow}${PS_DWARROWR} exit: $(df::prompt_status code)${reset}\n"

  PS_PREVIOUS_PWD="$PWD"
}

df::prompt_handler 'dotfiles_prompt'
df::prompt_on
