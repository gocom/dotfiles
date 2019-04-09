df::color_scheme ~/.dircolors /usr/local/share/dircolors

# Color-aware aliases.

if df::color_has_auto; then
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
