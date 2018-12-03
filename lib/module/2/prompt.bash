
dotfiles_prompt () {
  df::color -e

  df::prompt_add 5 "${blue}\u${reset}"
  df::prompt_add 5 "${magenta}@${reset}"
  df::prompt_add 5 "${blue}\h${reset}"

  if [ "$UID" -eq 0 ]; then
    df::prompt_append "m" "${red}${PS_TOXIC}${reset}"
  else
    df::prompt_append "m" "${magenta}${PS_COMMAND}${reset}"
  fi

  df::prompt_add "e0" "$TERM"
  df::prompt_add "e1" "${PWD##*/}"
  df::prompt_status || df::prompt_add w "${yellow}${PS_DWARROWR} exit: $(df::prompt_status code)${reset}\n"

  if [ "$(df::prompt_status code)" -eq 127 ]; then
    bshtr::remove_exact "$(bshtr::list 1)"
  fi
}

df::prompt_handler 'dotfiles_prompt'
df::prompt_on
