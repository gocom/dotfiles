# Appends a value to the prompt string.
#
# ```
# df::prompt_append 9 "Hello World!"
# ```
#
# @param {integer|string} [order=5] String position, a number between '1' to '9', 'u', 'a' or 'h'
# @param {string} value The string to add
# @api

df::prompt_append () {
  df::prompt_set ":append" "$@" || return 1
}

# Prepends a value to the prompt string.
#
# ```
# df::prompt_prepend 9 "Hello World!"
# ```
#
# @param {integer|string} [order=5] String position, a number between '1' to '9', 'u', 'a' or 'h'
# @param {string} value The string to add
# @api

df::prompt_prepend () {
  df::prompt_set ":prepend" "$@" || return 1
}

# Replaces a prompt string value in the given field position.
#
# ```
# df::prompt_replace 9 "Hello World!"
# ```
#
# @param {integer|string} [order=5] String position, a number between '1' to '9', 'u', 'a' or 'h'
# @param {string} value The string to add
# @api

df::prompt_replace () {
  df::prompt_set ":replace" "$@" || return 1
}

# Adds a value to the prompt string.
#
# This is the same as append, but doesn't add spacing after the field.
#
# ```
# df::prompt_add 9 "Hello World!"
# ```
#
# @param {integer|string} [order=5] String position, a number between '1' to '9', 'u', 'a' or 'h'
# @param {string} value The string to add
# @api

df::prompt_add () {
  df::prompt_set ":add" "$@" || return 1
}

# Sets a prompt string value in the given position.
#
# ```
# df::prompt_set ":append" 9 "Hello World!"
# ```
#
# @param {position} [position] Whether ':prepend', ':append', ':replace' or ':add'
# @param {integer|string} [order=5] Field position, a number between '1' to '9', 'u', 'a', 'h', 'e0' or 'e1'
# @param {string} value The string
# @private

df::prompt_set () {
  local position="$1"
  local order="$2"
  local value
  local item
  local current

  local after
  local between
  local empty
  local insert

  case "$position" in
    ":append")
      after=" "
      between=" "
      empty="no"
      insert="after"
      ;;
    ":prepend")
      after=" "
      between=" "
      empty="no"
      insert="before"
      ;;
    ":replace")
      after=""
      between=""
      empty="yes"
      insert="replace"
      ;;
    ":add")
      after=""
      between=""
      empty="no"
      insert="after"
      ;;
  esac

  shift || return 1
  shift || return 1

  for item in "$@"; do
    if [ "$item" ]; then
      if [ "$value" ]; then
        value="$value${between}$item"
      else
        value="$item"
      fi
    fi
  done

  if ! [ "$value" ] && [ "$empty" = "no" ]; then
    return 0
  fi

  if [ "$insert" = "after" ] || [ "$insert" = "before" ]; then
    current="$(df::prompt_get "$order")"

    if [ "$current" ]; then
      if [ "$insert" = "after" ]; then
        value="${current}${between}${value}"
      else
        value="${value}${between}${current}"
      fi
    fi
  fi

  value="${value%%"$after"}"
  value="${value##"$after"}"

  if [ "$value" ]; then
    value="${value}${after}"
  fi

  case "$order" in
    1)  DOTFILES_PS1_1="$value" ;;
    2)  DOTFILES_PS1_2="$value" ;;
    3)  DOTFILES_PS1_3="$value" ;;
    4)  DOTFILES_PS1_4="$value" ;;
    5)  DOTFILES_PS1_5="$value" ;;
    6)  DOTFILES_PS1_6="$value" ;;
    7)  DOTFILES_PS1_7="$value" ;;
    8)  DOTFILES_PS1_8="$value" ;;
    9)  DOTFILES_PS1_9="$value" ;;
    u)  DOTFILES_PS1_U="$value" ;;
    a)  DOTFILES_PS1_A="$value" ;;
    h)  DOTFILES_PS1_H="$value" ;;
    m)  DOTFILES_PS1_M="$value" ;;
    w)  DOTFILES_PS1_W="$value" ;;
    e0) DOTFILES_PS1_E0="$value" ;;
    e1) DOTFILES_PS1_E1="$value" ;;
    e2) DOTFILES_PS1_E2="$value" ;;
    *)  return 1 ;;
  esac
}

# Gets a prompt string value.
#
# @param {integer|string} order The position to get
# @print {string} The value
# @private

df::prompt_get () {
  case "$1" in
    1)  echo "${DOTFILES_PS1_1:-}" ;;
    2)  echo "${DOTFILES_PS1_2:-}" ;;
    3)  echo "${DOTFILES_PS1_3:-}" ;;
    4)  echo "${DOTFILES_PS1_4:-}" ;;
    5)  echo "${DOTFILES_PS1_5:-}" ;;
    6)  echo "${DOTFILES_PS1_6:-}" ;;
    7)  echo "${DOTFILES_PS1_7:-}" ;;
    8)  echo "${DOTFILES_PS1_8:-}" ;;
    9)  echo "${DOTFILES_PS1_9:-}" ;;
    u)  echo "${DOTFILES_PS1_U:-}" ;;
    a)  echo "${DOTFILES_PS1_A:-}" ;;
    h)  echo "${DOTFILES_PS1_H:-}" ;;
    m)  echo "${DOTFILES_PS1_M:-}" ;;
    w)  echo "${DOTFILES_PS1_W:-}" ;;
    e0) echo "${DOTFILES_PS1_E0:-}" ;;
    e1) echo "${DOTFILES_PS1_E1:-}" ;;
    *)  return 1 ;;
  esac
}

# Removes command prompt value by the specified order.
#
# ```
# df::prompt_remove 5
# ```
#
# @param {integer|string} order The position to remove
# @private

df::prompt_remove () {
  local order

  for order in "$@"; do
    df::prompt_replace "$order" "" || return 1
  done
}

# Clears the prompt string.
#
# The `PS1` string will be empty after running this function.
#
# ```
# df::prompt_clear
# ```
#
# @private

df::prompt_clear () {
  df::prompt_remove 1 2 3 4 5 6 7 8 9 u a h m w e0 e1 e2
}

# Resets the prompt to defaults.
#
# ```
# df::prompt_reset
# ```
#
# @private

df::prompt_reset () {
  # Store the status of last command. Since we are in the first prompt
  # command handler, it points to the actual command run by user - at least
  # often.
  PROMPT_STATUS="$?"

  # Clear the current prompt.
  df::prompt_clear
}

# Gets the prompt status.
#
# Returns the last command exit status.
#
# @param {string} [export] Data to export
# @return {integer} Exit status, either '0' or '1'
#
# @api

df::prompt_status () {
  if [ "$#" -ge 1 ] && [ "$1" = "code" ]; then
    echo "${PROMPT_STATUS:-}"
  fi

  if [ "${PROMPT_STATUS:-0}" -eq 0 ]; then
    return 0
  fi

  return 1
}

# Adds a new prompt command.
#
# ```
# df::prompt_command_add 'my_function'
# ```
#
# @param {string} [position] Either ':append' or ':prepend'
# @param {string} command The command to run
# @see df::prompt_command_append
# @see df::prompt_command_prepend
# @private

df::prompt_command_add () {
  local item
  local position=":append"
  local list
  local out=""

  df::prompt_command_init

  if [ "$1" = ":append" ] || [ "$1" = ":prepend" ]; then
    position="$1"
    shift || return 1
  fi

  for item in "$@"; do
    df::prompt_command_remove "$item"

    if [ "$out" ]; then
      out="${out}; ${item}"
    else
      out="${item}"
    fi
  done

  list="$(df::prompt_command_list)"

  if [ "$list" ]; then
    if [ "$position" = ":prepend" ]; then
      out="${out}; ${list}"
    else
      out="${list}; ${out}"
    fi
  fi

  DOTFILES_PROMPT_COMMAND="$out"
}

# Appends a prompt command.
#
# Adds a prompt command callback at the end of the command queue.
# While the command can be anything, a simple function name is preferred.
#
# ```
# df::prompt_command_append 'my_function'
# ```
#
# @param {string} command The command
# @see df::prompt_command_prepend
# @api

df::prompt_command_append () {
  df::prompt_command_add ":append" "${@:1}" || return 1
}

# Prepends a prompt command.
#
# Adds a prompt command callback at the beginning of the command queue.
# While the command can be anything, a simple function name is preferred.
#
# ```
# df::prompt_command_prepend 'my_function'
# ```
#
# @param {string} command The command
# @see df::prompt_command_append
# @api

df::prompt_command_prepend () {
  df::prompt_command_add ":prepend" "${@:1}" || return 1
}

# Removes a prompt command.
#
# Removes the specified function name from the prompt command queue.
#
# ```
# df::prompt_command_remove "my_function"
# ```
#
# @param {string} command The command
# @api

df::prompt_command_remove () {
  local needle="$1"
  local list="$(df::prompt_command_list)"
  local item
  local out=""
  local IFS=";"
  local i

  df::prompt_command_init

  for i in $list; do
    item="$( printf '%s' "$i" | sed 's/^[ ]*//' )"
    item="$( printf '%s' "$item" | sed 's/[ ]*$//' )"

    if ! [ "$item" = "$needle" ]; then
      if [ "$out" ]; then
        out="${out};${i}"
      else
        out="$i"
      fi
    fi
  done

  DOTFILES_PROMPT_COMMAND="$out"
}

# Lists prompt commands.
#
# ```
# df::prompt_command_list
# ```
#
# @print {string} Commands
# @private

df::prompt_command_list () {
  df::prompt_command_init
  echo "$( printf '%s' "${DOTFILES_PROMPT_COMMAND:-}" | sed 's/;[ ]*$//' )"
}

# Initializes prompt commands.
#
# Sets the initial state to PROMPT_COMMAND environment variable.
#
# ```
# df::prompt_command_init
# ```
#
# @private

df::prompt_command_init () {
  if [ "${DOTFILES_PROMPT_COMMAND_INITIALIZED:-0}" -eq 0 ]; then
    DOTFILES_PROMPT_COMMAND_INITIALIZED=1
    DOTFILES_PROMPT_COMMAND="${PROMPT_COMMAND:-}"
  fi
}

# Sets or gets the window title.
#
# ```
# df::prompt_window_title "\u@\h"
# df::prompt_window_title
# -> \u@\h
# ```
#
# @param {string} [title] The window title

df::prompt_window_title () {
  if [ "$#" -eq 0 ]; then
    echo "${DOTFILES_PROMPT_WINDOW_TITLE:-}"
    return 0
  fi

  DOTFILES_PROMPT_WINDOW_TITLE="$1"
}

# Sets or gets the tab title.
#
# ```
# df::prompt_tab_title "Reference"
# df::prompt_tab_title
# -> Reference
# ```
#
# @param {string} [title] The tab title

df::prompt_tab_title () {
  if [ "$#" -eq 0 ]; then
    echo "${DOTFILES_PROMPT_TAB_TITLE:-}"
    return 0
  fi

  DOTFILES_PROMPT_TAB_TITLE="$1"
}

# Checks color support.
#
# ```
# df::prompt_colors || echo "no?"
# df::prompt_colors "colors"
# ```
#
# The above prints "256" if the terminal says it supposedly supports colors.
#
# @param {string} [export] Data to export
# @private

df::prompt_has_colors () {
  local colors

  # Terminal client must say it wants colors.
  case "$TERM" in
    xterm-color|*-256color) ;;
    *) return 1 ;;
  esac

  # We need tput.
  if ! [ "$(command -v tput)" ] ; then
    return 1
  fi

  # Reports an error.
  if ! tput setaf 1 >/dev/null 2>&1; then
    return 1
  fi

  colors="$(tput colors)"

  if [ "${colors:-0}" -lt 8 ]; then
    return 1
  fi

  if [ "$#" -ge 1 ] && [ "$1" = "colors" ]; then
    echo "$colors"
  fi
}

# Checks locale-data's unicode readiness.
#
# Sees that the locale is set as UTF-8. Doesn't test the shell or the terminal
# itself.

df::prompt_has_unicode () {
  case "$LANG $LC_ALL" in
    *UTF-8*) ;;
    *) return 1 ;;
  esac
}

# Sets theme variables.
#
# @private

df::prompt_set_colors () {
  [ "${PS_RESET:-}" ]    || PS_RESET="$(df::prompt_tput sgr0)"
  [ "${PS_DIM:-}" ]      || PS_DIM="$(df::prompt_tput dim)"
  [ "${PS_BOLD:-}" ]     || PS_BOLD="$(df::prompt_tput bold)"
  [ "${PS_REV:-}" ]      || PS_REV="$(df::prompt_tput rev)"

  [ "${PS_RED:-}" ]      || PS_RED="$(df::prompt_tput setaf 1)"
  [ "${PS_GREEN:-}" ]    || PS_GREEN="$(df::prompt_tput setaf 2)"
  [ "${PS_YELLOW:-}" ]   || PS_YELLOW="$(df::prompt_tput setaf 3)"
  [ "${PS_BLUE:-}" ]     || PS_BLUE="$(df::prompt_tput setaf 4)"
  [ "${PS_MAGENTA:-}" ]  || PS_MAGENTA="$(df::prompt_tput setaf 5)"
  [ "${PS_CYAN:-}" ]     || PS_CYAN="$(df::prompt_tput setaf 6)"
  [ "${PS_WHITE:-}" ]    || PS_WHITE="$(df::prompt_tput setaf 7)"
  [ "${PS_BLACK:-}" ]    || PS_BLACK="$(df::prompt_tput setaf 8)"

  df::prompt_has_unicode || return 1

  [ "${PS_BLOCKED:-}" ]  || PS_BLOCKED="⊘"
  [ "${PS_BRANCH:-}" ]   || PS_BRANCH="‡"
  [ "${PS_CHECK:-}" ]    || PS_CHECK="✓"
  [ "${PS_COMMAND:-}" ]  || PS_COMMAND="⌘"
  [ "${PS_DOWN:-}" ]     || PS_DOWN="⇣"
  [ "${PS_DWARROWL:-}" ] || PS_DWARROWL="↲"
  [ "${PS_DWARROWR:-}" ] || PS_DWARROWR="↳"
  [ "${PS_ELLIPSIS:-}" ] || PS_ELLIPSIS="⋯"
  [ "${PS_LAMBDA:-}" ]   || PS_LAMBDA="λ"
  [ "${PS_LEFT:-}" ]     || PS_LEFT="⇠"
  [ "${PS_LINK:-}" ]     || PS_LINK="∞"
  [ "${PS_MERCURY:-}" ]  || PS_MERCURY="☿"
  [ "${PS_MUSIC:-}" ]    || PS_MUSIC="♫"
  [ "${PS_ORIGIN:-}" ]   || PS_ORIGIN="⊶"
  [ "${PS_OSX:-}" ]      || PS_OSX=""
  [ "${PS_RIGHT:-}" ]    || PS_RIGHT="⇢"
  [ "${PS_SKULL:-}" ]    || PS_SKULL="☠"
  [ "${PS_STAR:-}" ]     || PS_STAR="★"
  [ "${PS_THEREFORE}" ]  || PS_THEREFORE="∴"
  [ "${PS_TILDE}" ]      || PS_TILDE="∼"
  [ "${PS_TOXIC:-}" ]    || PS_TOXIC="☢"
  [ "${PS_UP:-}" ]       || PS_UP="⇡"
  [ "${PS_WARNING:-}" ]  || PS_WARNING="⚠"
  [ "${PS_DIRECTORY:-}" ]  || PS_DIRECTORY="↠"
}

# Unsets theme variables.
#
# @private

df::prompt_unset_colors () {
  unset PS_RESET PS_DIM PS_BOLD PS_REV PS_RED PS_GREEN PS_YELLOW PS_BLUE \
        PS_MAGENTA PS_CYAN PS_WHITE PS_BLACK \
        PS_BLOCKED PS_BRANCH PS_CHECK PS_COMMAND PS_DOWN PS_ELLIPSIS PS_LAMBDA \
        PS_LEFT PS_LINK PS_MUSIC PS_ORIGIN PS_OSX PS_RIGHT PS_SKULL PS_STAR \
        PS_TOXIC PS_UP PS_WARNING
}

# Outputs values wrapped in ANSI non-printing escape sequences.
#
# ```
# df::prompt_tput setaf 15
# ```
#
# @see tput
# @private

df::prompt_tput () {
  if ! [ "${DOTFILES_PROMPT_COLORS:-}" ]; then
    if df::prompt_has_colors; then
      DOTFILES_PROMPT_COLORS=1
    else
      DOTFILES_PROMPT_COLORS=0
    fi
  fi

  if [ "$DOTFILES_PROMPT_COLORS" -eq 1 ]; then
    printf '\[%s\]' "$(tput "$@")"
  fi
}

# Enables the prompt.
#
# ```
# df::prompt_on
# ```
#
# @api

df::prompt_on () {
  if [ "${DOTFILES_PROMPT_ENABLED:-0}" -eq 1 ]; then
    return 1
  fi

  DOTFILES_PROMPT_ENABLED=1
  DOTFILES_PROMPT_BAK_PS1="${PS1:-}"
  DOTFILES_PROMPT_BAK_PROMPT_COMMAND="${PROMPT_COMMAND:-}"

  if shopt -q promptvars; then
    DOTFILES_PROMPT_BAK_PROMPTVARS=1
  else
    DOTFILES_PROMPT_BAK_PROMPTVARS=0
  fi

  # Register prompt commands.
  df::prompt_command_init
  PROMPT_COMMAND="${DOTFILES_PROMPT_COMMAND:-}"

  # Load colors.
  df::prompt_set_colors

  # Disable expansion.
  shopt -u promptvars

  # Directory trim limit.
  PROMPT_DIRTRIM=1

  # Reset prompt.
  df::prompt_reset

  # Run prompt to set the values now.
  df::prompt_run

  # Register reset handler.
  df::prompt_command_prepend 'df::prompt_reset'

  # Register run handler.
  df::prompt_command_append 'df::prompt_run'
}

# Disables the prompt.
#
# ```
# df::prompt_off
# ```
#
# @api

df::prompt_off () {
  if [ "${DOTFILES_PROMPT_ENABLED:-0}" -eq 0 ]; then
    return 1
  fi

  df::prompt_unset_colors

  df::prompt_command_remove 'df::prompt_reset'
  df::prompt_command_remove 'df::prompt_run'

  if [ "${DOTFILES_PROMPT_BAK_PROMPTVARS:-0}" -eq 1 ]; then
    shopt -s promptvars
  fi

  PS1="$DOTFILES_PROMPT_BAK_PS1"
  PROMPT_COMMAND="$DOTFILES_PROMPT_BAK_PROMPT_COMMAND"
  unset DOTFILES_PROMPT_ENABLED
}

# Registers a prompt handler.
#
# ```
# my_ps1_function () {
#  df::prompt_append 1 "Hello World!"
# }
#
# df::prompt_handler "my_ps1_function"
# ```
#
# The above would append string 'Hello World!' to your 'PS1'.
#
# @param {string} $command The command
# @api

df::prompt_handler () {
  df::prompt_command_prepend "df::prompt_reset"
  df::prompt_command_append "$@" "df::prompt_run"
}

# Updates the prompt string.
#
# This function is the run handler that builds and sets the prompt string.
#
# @private

df::prompt_run () {
  if [ "$DOTFILES_PROMPT_WINDOW_TITLE" ]; then
    printf '\e]0;%s\007' "$DOTFILES_PROMPT_WINDOW_TITLE"
  else
    printf "\e]0;%s\007" "$DOTFILES_PS1_E0"
  fi

  if [ "$DOTFILES_PROMPT_TAB_TITLE" ]; then
    printf '\e]1;%s\007' "$DOTFILES_PROMPT_TAB_TITLE"
  else
    printf "\e]1;%s\007" "$DOTFILES_PS1_E1"
  fi

  printf "\e]2;%s\007" "$DOTFILES_PS1_E2"

  PS1=""

  if [ "$(df::prompt_column)" -gt 1 ]; then
    PS1="${PS1}\n"
  fi

  PS1="${PS1}${DOTFILES_PS1_W:-}"
  PS1="${PS1}${DOTFILES_PS1_1:-}"
  PS1="${PS1}${DOTFILES_PS1_2:-}"
  PS1="${PS1}${DOTFILES_PS1_3:-}"
  PS1="${PS1}${DOTFILES_PS1_4:-}"
  PS1="${PS1}${DOTFILES_PS1_5:-}"
  PS1="${PS1}${DOTFILES_PS1_U:-}"
  PS1="${PS1}${DOTFILES_PS1_A:-}"
  PS1="${PS1}${DOTFILES_PS1_H:-}"
  PS1="${PS1}${DOTFILES_PS1_6:-}"
  PS1="${PS1}${DOTFILES_PS1_7:-}"
  PS1="${PS1}${DOTFILES_PS1_8:-}"
  PS1="${PS1}${DOTFILES_PS1_9:-}"
  PS1="${PS1}${DOTFILES_PS1_M:-}"
}

# Gets the cursor column position.
#
# This is mainly used to figure out whether we should add a newline to the
# prompt string when the command output doesn't end in one.
#
# ```
# printf '%s' "No newline"; \
# df::prompt_column
# ```
#
# The above will print '9'.
#
# @print {integer} Column position
# @private

df::prompt_column () {
  local columns
  local rows
  IFS=';' read -sdR -p $'\E[6n' rows columns
  echo "${columns}"
}
