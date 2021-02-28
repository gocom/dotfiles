# Adds values to a path-list variable.
#
# ```
# df::path --prepend "path" "path/to/one" "path/to/two"
# ```
#
# @api

df::path () {
  local OPTIND OPTARG OPTERR IFS \
    option args path name position delimiter out list remove item current

  args=()

  for option in "$@"; do
    case "$option" in
      -*) break ;;
      *) args+=("$option"); shift ;;
    esac
  done

  delimiter=":"
  name="path"

  while getopts ":apd:n:-:" option; do
    case "$option" in
      -)
        case "$OPTARG" in
          append) position="append" ;;
          delimiter) delimiter="${!OPTIND}"; OPTIND=$(($OPTIND + 1)) ;;
          delimiter=*) delimiter="${OPTARG#*=}" ;;
          name) name="${!OPTIND}"; OPTIND=$(($OPTIND + 1)) ;;
          name=*) name="${OPTARG#*=}" ;;
          prepend) position="prepend" ;;
          remove) remove=1 ;;
        esac;;
      a) position="append" ;;
      d) delimiter="$OPTARG" ;;
      n) name="$OPTARG" ;;
      p) position="prepend" ;;
      r) remove=1 ;;
    esac
  done

  shift "$(($OPTIND - 1))"
  set -- "${args[@]}" "$@"

  if [ "$#" -eq 0 ]; then
    return 1
  fi

  IFS="$delimiter"
  current="$(df::env "$name")" || return 1

  if [ "$#" -eq 0 ]; then
    for option in $current; do
      echo "$option"
    done

    return 0
  fi

  # Remove given items from the current path list.

  for item in $current; do
    for option in "$@"; do
      if [ "$option" = "$item" ]; then
        break
      fi
    done

    if ! [ "$option" = "$item" ]; then
      if [ "$list" ]; then
        list="$list$delimiter$item"
      else
        list="$item"
      fi
    fi
  done

  if [ "$remove" ]; then
    df::env "$name" "$list" || return 1
    return 0
  fi

  # Build list.

  for option in "$@"; do
    if ! [ -e "$option" ]; then
      continue
    fi

    if [ "$out" ]; then
      out="${out}${delimiter}${option}"
    else
      out="$option"
    fi
  done

  if ! [ "$out" ]; then
    return 0
  fi

  if [ "$list" ]; then
    if [ "$position" = "prepend" ]; then
      out="${out}${delimiter}${list}"
    else
      out="${list}${delimiter}${out}"
    fi
  fi

  df::env "$name" "$out" || return 1
  return 0
}
