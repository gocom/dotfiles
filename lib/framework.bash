app () {
  local color colors f b

  app_name="${0##*/}"
  app_version="${1:-0.0.0}"

  color=1
  colors=0
  setaf=()
  setab=()

  if [ "${TERM:-}" = "dumb" ] || [ "${NO_COLOR:-}" ]; then
    color=""
  fi

  while [ "$colors" -le 8 ]; do
    if ! [ "$color" ]; then
      setaf+=("")
      setab+=("")
      continue
    fi

    if [ "$colors" -eq 0 ]; then
      f="$(tput sgr0)"
      b="$f"
    else
      f="$(tput setaf "$colors")"
      b="$(tput setab "$colors")"
    fi

    setaf+=("$f")
    setab+=("$b")
    ((colors++))
  done

  reset="${setaf[0]}"
  red="${setaf[1]}"
  green="${setaf[2]}"
  yellow="${setaf[3]}"
  blue="${setaf[4]}"
  magenta="${setaf[5]}"
  cyan="${setaf[6]}"
  white="${setaf[7]}"
  black="${setaf[8]}"

  bgred="${setab[1]}"
  bggreen="${setab[2]}"
  bgyellow="${setab[3]}"
  bgblue="${setab[4]}"
  bgmagenta="${setab[5]}"
  bgcyan="${setab[6]}"
  bgwhite="${setab[7]}"
  bgblack="${setab[8]}"
}

use () {
  local option status

  for option in "$@"; do
    if ! [ "$(command -v "$option")" ]; then
      error "Required external command missing: $option"
      status=1
    fi
  done

  if ! [ "${status:-0}" -eq 0 ]; then
    exit 1
  fi
}

run () {
  status=0
  output=""

  if ! [ "${dryrun:-}" ] && ! [ "${run:-}" = 0 ]; then
    output="$("$@")" || status="$?"
  fi

  return "$status"
}

#: msg -- Print a message.
#:
#: Usage:
#:   $ msg [message ...]

msg () {
  local message

  for message in "$@"; do
    echo "$message"
  done
}

#: log -- Log a message if not running in silent mode.
#:
#: Usage:
#:   $ log [message ...]

log () {
  if ! [ "${silent:-}" ]; then
    msg "$@"
  fi
}

#: error -- Log an error.
#:
#:

error () {
  log "$@" >&2
}

#: fatal -- Log an error and exit.
#:
#: Usage:
#:   $ fatal [message ...]

fatal () {
  error "$@"
  exit 1
}

#
# $ row '%-16s' "value1" '%30s' "value2"
#

row () {
  local spacing cell column format row width

  for column in "$@"; do
    if ! [ "$format" ]; then
      format="$column"
      continue
    fi

    width="$(printf '%s' "$format" | sed 's/[^0-9]//g')"
    cell="$(printf '%s' "$option" | head -n1 | cut -c -$width)"
    row="$row$spacing$(printf "$format" "$cell")"
    spacing="  "
    format=""
  done

  echo "$row"
}

option () {
  local OPTIND OPTARG opts option short long flag fulfill required value

  value=":"

  while getopts ":n:l:f:v" option $1; do
    case "$option" in
      n) short="$OPTARG" ;;
      l) long="$OPTARG" ;;
      f) flag=1; value="" ;;
      v) fulfill=1 ;;
      r) required=1 ;;
      *) ;;
    esac
  done

  shift
  opts=":"

  if [ "$short" ]; then
    opts+="$short$value"
  fi

  if [ "$long" ]; then
    opts+="-:"
  fi

  while getopts "$opts" option "$@"; do
    if [ "$option" = "$short" ]; then
      printf '%s' "$OPTARG"
      return 0
    fi

    # @todo long parsing

    if [ "$option" = ":" ] && [ "$fulfill" ]; then
      return 1
    fi
  done

  if [ "$required" ]; then
    return 1
  fi

  return 0
}

prompt () {
  local OPTIND name value message default

  if [ "$value" ]; then
    printf '%s' "$value"
    return
  fi

  if [ "$message" ]; then
    read -r -p "$message: " value
  fi

  if [ "$value" ]; then
    printf '%s' "$value"
    return
  fi

  printf '%s' "$default"
  return
}

yes () {
  case "${1:-}" in
    Y*|y*) return 0 ;;
    *) return 1 ;;
  esac
}

no () {
  yes || return 0
}
