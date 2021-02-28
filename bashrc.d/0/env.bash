# Access environment variables through pretty names.
#
# ```
# df::env "path" "/new/path"
# df::env "path"
# > /new/path
# ```
#
# @param {string} name The name of the variable
# @param {string} value The new value
# @print If only name is given, prints the value
# @return Exit code 1, if the given name is invalid

df::env () {
  if [ "$#" -eq 1  ]; then
    case "$1" in
      cdpath)        echo "${CDPATH:-}" ;;
      gempath)       echo "${GEM_PATH:-}" ;;
      infopath)      echo "${INFOPATH:-}" ;;
      manpath)       echo "${MANPATH:-}" ;;
      path)          echo "${PATH:-}" ;;
      pkgconfigpath) echo "${PKG_CONFIG_PATH:-}" ;;
      *)             return 1 ;;
    esac
  fi

  if [ "$#" -eq 2 ]; then
    case "$1" in
      cdpath)        export CDPATH="$2" ;;
      gempath)       export GEM_PATH="$2" ;;
      infopath)      export INFOPATH="$2" ;;
      manpath)       export MANPATH="$2" ;;
      path)          export PATH="$2" ;;
      pkgconfigpath) export PKG_CONFIG_PATH="$2" ;;
      *)             return 1 ;;
    esac
  fi

  return 0
}

# Compares version numbers.
#
# Makes sure the provided "major.minor" version number is equal or greater than
# the expected version number.
#
# ```
# version_compare "4.3" "4.1" || echo "nope, 4.3 is greater"
# version_compare "4.1" || echo "bash version is not >= 4.1"
# ```
#
# @param {string} expects Version number compare to
# @param {string} [version] If not set, uses Bash version
# @return 0 if 'version' meets 'expects', 1 otherwise

df::is_version () {
  local aversion bversion amajor aminor bmajor bminor

  aversion="${1:-}"
  bversion="${2:-}"

  if ! [ "$bversion" ] && [ "${BASH_VERSION:-}" ]; then
    bversion="${BASH_VERSION%.*}"
  fi

  if ! [ "$aversion" ] || ! [ "$bversion" ]; then
    return 1
  fi

  amajor="${aversion%.*}"
  aminor="${aversion#*.}"
  bmajor="${bversion%.*}"
  bminor="${bversion#*.}"

  if [ "$bmajor" -gt "$amajor" ]; then
    return 0
  fi

  if [ "$bmajor" -eq "$amajor" ] && [ "$bminor" -ge "$aminor" ]; then
    return 0
  fi

  return 1
}

# Check shell mode.
#
# @param {string} mode The mode to check against

df::is_shell () {
  case "${-:-}" in
    *"${1:-}"*) return 0 ;;
    *) return 1 ;;
  esac
}
