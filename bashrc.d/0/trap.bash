# Adds trap command to the given signal.
#
# ```
# my_function () {
#  echo "Hello World!"
# }
#
# df::trap_add "my_function" ":append" "EXIT"
# ```
#
# @param {string} command The command
# @param {string} [position] Either ':append' or ':prepend'
# @param {string} signal The signal
# @see df::trap_prepend
# @see df::trap_append
# @private

df::trap_add () {
  local add="$1"
  local position="$2"
  local signal
  local traps

  shift 2 || return 1

  for signal in "$@"; do
    traps=$(df::trap_list "$signal")

    if [ "$traps" ]; then
      if [ "$position" = ":append" ]; then
        traps="${traps}; ${add}"
      else
        traps="${add}; ${traps}"
      fi
    else
      traps="${add}"
    fi

    trap "$traps" "$signal" || return 1
  done
}

# Prepends trap command to the given signal.
#
# ```
# my_function () {
#   echo "Hello World!"
# }
#
# df::trap_prepend "my_function" "EXIT"
# ```
#
# @param {string} command The command
# @param {string} signal The signal
# @see df::trap_append
# @api

df::trap_prepend () {
  df::trap_add "$1" ":prepend" "${@:2}" || return 1
}

# Appends trap command to the given signal.
#
# ```
# my_function () {
#  echo "Hello World!"
# }
#
# trap_append "my_function" "EXIT"
# ```
#
# @param {string} command The command
# @param {string} signal The signal
# @see df::trap_prepend
# @api

df::trap_append () {
  df::trap_add "$1" ":append" "${@:2}" || return 1
}

# Removes a trap command.
#
# Removes the given function name from the trap command list.
#
# For this to work properly, the traps should use simple function names as
# callback handlers, rather than complex commands. Pariticularly,
# things will break if a trap command contains `\r`, `\n` or semi-colons `;`.
#
# ```
# df::trap_remove "my_function" "EXIT"
# ```
#
# @param {string} $command The command to remove
# @param {string} $signal The signal
# @api

df::trap_remove () {
  local needle="$1"
  local signal
  local traps

  shift || return 1

  for signal in "$@"; do
    traps="$(df::trap_list "$signal")"

    if [ "$traps" ]; then
      traps=$(printf '%s' "$traps" | sed "$(printf 's/^%s;?$//' "$needle")")
      traps=$(printf '%s' "$traps" | sed "$(printf 's/; %s;?$//' "$needle")")
      traps=$(printf '%s' "$traps" | sed "$(printf 's/; %s;/;/g' "$needle")")
      trap "$traps" "$signal"
    fi
  done
}

# Lists traps for the given signal.
#
# ```
# df::trap_list "EXIT"
# ```
#
# @param {string} signal The signal
# @api

df::trap_list () {
  local signal
  local traps

  for signal in "$@"; do
    traps=$(trap -p "$signal" | awk -F "'" '{print $2}')
    traps=$(printf '%s' "$traps" | sed 's/;[ \t\r\n]*$//')
    echo "$traps"
  done
}
