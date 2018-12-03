if ! [ "${JAVA_HOME:-}" ] && [ -e "$HOME/.java_home" ]; then
  export JAVA_HOME="$HOME/.java_home"
fi
