shopt -s cdspell
shopt -s complete_fullquote
shopt -s dirspell
shopt -s hostcomplete

if [ -f "/usr/local/share/bash-completion/bash_completion" ]; then
  . "/usr/local/share/bash-completion/bash_completion"
elif [ -f "/usr/local/etc/bash_completion" ]; then
  . "/usr/local/etc/bash_completion"
elif [ -f "/usr/share/bash-completion/bash_completion" ]; then
  . "/usr/share/bash-completion/bash_completion"
elif [ -f "/etc/bash_completion" ]; then
  . "/etc/bash_completion"
fi

df::path -p -n "cdpath" "." ".." "$HOME/Links"
