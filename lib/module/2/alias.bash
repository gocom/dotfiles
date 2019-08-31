# Filelist defaults.
alias ls="ls -hpq --color=auto --hide=$'Icon\r'"

# Filelist with full information.
alias ll='ls -alF --group-directories-first'

# Filelist including hidden files.
alias la='ls -A'

# Filelist with directories marked.
alias l='ls -CF'

# Source local environment variables to the shell session
#
# $ dotenv [filesuffix]
dotenv() {
  local file

  if [ "${1:-}" ]; then
    file=".env.$1"
  elif [ "${ENVIRONMENT:-}" ]; then
    file=".env.$ENVIRONMENT"
  else
    file=".env"
  fi

  if ! [ -e "$file" ]; then
    echo "No '$file' file found in the current working directory" >&2
    return 1
  fi

  set -a
  . .env
  set +a

  echo "Loaded environment variables from '$file'"
}

# Calculator.
= () {
  calc "$@"
}

# Create and open a directory
#
# @param {string} directory The directory
# @return {integer}

mkcdir () {
  local path

  if [ "$#" -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Create multiple directories at once, and go to the last one."
    echo "usage: $ $FUNCNAME directory ..."
    return 0
  fi

  for path in "$@"; do
    mkdir -p -- "$path" || return 1
  done

  cd -P -- "$path" || return 1
}

# Go to the directories real path.

rd () {
  if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    echo "Change the working directory to the links real path."
    echo "usage: $ $FUNCNAME [directory]"
    return 0
  fi

  cd "$@" > /dev/null || return 1
  cd -P -- "$(pwd -P)" > /dev/null || return 1
}
