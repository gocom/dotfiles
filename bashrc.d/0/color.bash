# Tests whether coreutils support `--color=auto`.
#
# ```
# df::color_has_auto
# ```
#
# @private

df::color_has_auto () {
  ls ~ --color=auto >/dev/null 2>&1 || return 1
}

# Tests whether dircolors is supported.
#
# ```
# df::color_has_dircolors || echo "Nah?"
# ```
#
# @private

df::color_has_dircolors () {
  command -v dircolors >/dev/null 2>&1 || return 1
}

# Sets dircolors scheme.
#
# Loads the color scheme from the given dircolors database file
# and assigns it to LS_Colors.
#
# ```
# df::color_scheme ~/.dircolors /etc/dircolors
# ```
#
# @api

df::color_scheme () {
  local file

  export CLICOLOR=1
  export LSCOLORS=ExFxBxDxCxegedabagacad

  if ! df::color_has_dircolors; then
    return 0
  fi

  for file in "$@"; do
    if [ -f "$file" ]; then
      eval "$(dircolors -b "$file")" || return 1
      return 0
    fi
  done

  eval "$(dircolors -b)" || return 1
}

# Prints a color table.
#
# ```
# df::color_table
# ```
#
# @api

df::color_table () {
  local i reset colors color dim reverse bold number background

  i=0
  reset="$(tput sgr0)"
  colors="$(tput colors)"
  color="$(tput setaf 15)"

  dim="$(tput dim)"
  reverse="$(tput rev)"
  bold="$(tput bold)"

  for setcolor in setab setaf; do
    i=0

    while [ "$i" -lt "$colors" ]; do
      background="$(tput $setcolor $i)"
      number="$(printf ' %03d ' "$i")"
      printf '%s' "${bold}${color}${background}${number}${reset}"
      i="$(($i + 1))"

      if [ "$(($i % 16))" -eq 0 ]; then
        echo ""
      fi
    done
  done
}

#: Initialize color variables.
#:
#: Generates variables containing ANSI codes, or empty strings, depending on if
#: the terminal supports colors.
#:
#: Options:
#:
#: -E, --escape  Wrap ANSI codes in to square brackets
#: --color       Enable color support
#: --no-color    Disable color support

df::color () {
  local OPTIND OPTARG OPTERR args option color escape colors f b action

  export DOTFILES_COLOR
  export DOTFILES_COLORS

  color=1
  escape=0

  setaf=()
  setab=()

  if [ "${DOTFILES_COLOR_INIT:-0}" -eq 0 ]; then
    DOTFILES_COLOR=0
    DOTFILES_COLORS=0

    case "${TERM:-}" in
      xterm-color|*-256color)
        if [ "$(command -v tput)" ] && tput setaf 1 > /dev/null 2>&1; then
          DOTFILES_COLORS="$(tput colors 2> /dev/null)"

          if [ "${DOTFILES_COLORS:-0}" -gt 7 ]; then
              DOTFILES_COLOR=1
          fi
        fi
      ;;
    esac

    DOTFILES_COLOR_INIT=1
  fi

  args=()

  for option in "$@"; do
    case "$option" in
      -*) break ;;
      *) args+=("$option"); shift ;;
    esac
  done

  while getopts ":e-:" option; do
    case "$option" in
      -)
        case "$OPTARG" in
          color) color=1 ;;
          escape) escape=1 ;;
          no-color) color=0 ;;
        esac;;
      e) escape=1 ;;
    esac
  done

  shift "$(($OPTIND - 1))"
  set -- "${args[@]}" "$@"

  action="${1:-}"

  case "$action" in
    support)
      if [ "$DOTFILES_COLOR" -eq 1 ]; then
        return 0
      fi

      return 1
      ;;
    unset)
      unset reset red green yellow blue magenta cyan white black \
        bgred bggreen bgyellow bgblue bgmagenta bgcyan bgwhite bgblack \
        setaf setab DOTFILES_COLOR_INIT DOTFILES_COLOR DOTFILES_COLORS
      return 0
    ;;
  esac

  if [ "$color" -eq 1 ] && [ "$DOTFILES_COLOR" -eq 1 ] && ! [ "${NO_COLOR:-}" ]; then
    color=1
  else
    color=0
  fi

  colors=0

  while [ "$colors" -le 8 ]; do
    if [ "$color" -eq 0 ]; then
      f=""
      b=""
    else
      if [ "$colors" -eq 0 ]; then
        f="$(tput sgr0)"
        b="$f"
      else
        f="$(tput setaf "$colors")"
        b="$(tput setab "$colors")"
      fi

      if [ "$escape" -eq 1 ]; then
        if [ "$f" ]; then
          f="$(printf '\[%s\]' "$f")"
        fi

        if [ "$b" ]; then
          b="$(printf '\[%s\]' "$b")"
        fi
      fi
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

  return 0
}
