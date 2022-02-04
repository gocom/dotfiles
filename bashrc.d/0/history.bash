# Exclude a command pattern from history.
#
# Matching command patterns will be outright blocked from ending into
# the history. This is a wrapper for `HISTIGNORE` built-in variable and
# supports the same syntax.
#
# ```
# bshtr::ignore "&" " *" "\\\\t*"
# ```
#
# @param {glob} command The command string to ignore
# @api

bshtr::ignore() {
  for i in "$@"; do
    if [ "${HISTIGNORE:-}" ]; then
      HISTIGNORE="$HISTIGNORE:$i"
    else
      HISTIGNORE="$i"
    fi
  done
}

# Marks matching command patterns for removal.
#
# The command pattern must be a valid POSIX regular expression.
#
# ```
# bshtr::remove "&" " *" "\\\\t*"
# ```
#
# @param {regex} command The command string to remove
# @api

bshtr::remove() {
  local pattern i

  for i in "$@"; do
    pattern="$(printf '^%s$' "$i")"

    if [ "${BSHTR_REMOVE:-}" ]; then
      BSHTR_REMOVE="${BSHTR_REMOVE}|${pattern}"
    else
      BSHTR_REMOVE="$pattern"
    fi
  done
}

# Marks exact matching command for removal.
#
# ```
# bshtr::remove_exact "cd /mnt/work"
# ```
#
# @param {string} command The command string to remove
# @api

bshtr::remove_exact() {
  local pattern i

  for i in "$@"; do
    if [ "${BSHTR_REMOVE_EXACT:-}" ]; then
      pattern="$(printf '\n%s', "$i")"
      BSHTR_REMOVE_EXACT="${BSHTR_REMOVE_EXACT}\n${pattern}"
    else
      BSHTR_REMOVE_EXACT="$i"
    fi
  done
}

# Plain list of history commands.
#
# Any options are passed down to `history`.
#
# ```
# bshtr::list
# bshtr::list 1
# ```
#
# @see history
# @api

bshtr::list() {
  echo "$(history "$@" | sed 's/^[0-9 ]*//')"
}

# Searches history.
#
# ```
# bshtr::search keyword
# ```
#
# @see history
# @api

bshtr::search() {
  if [ "$#" -eq 0 ]; then
    return 1
  fi

  history | grep -i "$1"
}

# Forgets the last, or matching, item from command history.
#
# If no arguments are provided, removes the last command from history.
# Optionally a list of regular expressions can be provided; each matching
# command will be removed, or a list of history line numbers.
#
# Let's say your history contains:
#
# ```
# $ history
# 1  cd
# 2  ls
# 3  pwd
# 4  echo "hello"
# 5  echo "world?"
# 6  echo "World!"
# ```
#
# Your could forget the last `echo` command:
#
# ```
# bshtr::forget
# ```
#
# Or remove both `cd` and `ls`, but leave rest intact:
#
# ```
# bshtr::forget "cd" "ls"
# ```
#
# Or remove specific history lines:
#
# ```
# bshtr::forget 2 3
# ```
#
# Options are treated as line numbers, if the first option is an integer;
# command patterns otherwise.
#
# For this function to work properly, it, or the used alias, must not be
# on the `HISTIGNORE` list.
#
# @param {string} [command] The command to remove
# @api

bshtr::forget() {
  local last line numeric original

  if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    echo "usage: $ $FUNCNAME [command ...]" >&1
    return 0
  fi

  last="$(history | awk 'END{print $1-1}')"

  if ! [ "$last" ] || [ "$last" -lt 1 ]; then
    return 0
  fi

  if [ "$#" -ge 1 ]; then
    case "$1" in
      ''|*[!0-9]*) ;;
      *) numeric="$1" ;;
    esac

    if [ "$numeric" ]; then
      history -n || return 1

      for line in "$@"; do
        history -d "$line" || return 1
      done

      history -w || return 1
    else
      original="${BSHTR_REMOVE:-}"
      BSHTR_REMOVE=""
      bshtr::write
      bshtr::remove "$@"
      bshtr::purge
      bshtr::read
      BSHTR_REMOVE="$original"
    fi

    return 0
  fi

  history -n || return 1
  history -d "$last" || return 1
  history -w || return 1

  return 0
}

# Assert history.
#
# Makes sure that the history file exists and can be worked on.
#
# @return {integer} 1 on failure
# @private

bshtr::assert() {
  local lines

  if [ "${HISTTIMEFORMAT:-}" ]; then
    return 1
  fi

  if ! [ "${HISTFILE:-}" ] || ! [ -w "$HISTFILE" ] || ! [ -r "$HISTFILE" ]; then
    return 1
  fi

  lines=$(wc -l < "$HISTFILE")

  if ! [ "$lines" ] || [ "$lines" -lt 1 ]; then
    return 1
  fi
}

# Writes command history to a file.
#
# Dumps command buffer to `$HISTFILE`.
#
# @private

bshtr::write() {
  history -a || return 1
}

# Reads command history from a file.
#
# Reads command history from `$HISTFILE`.
#
# @private

bshtr::read() {
  history -a || return 1
  history -c || return 1
  history -r || return 1
}

# Removes marked command patterns from the history file.
#
# ```
# bshtr::remove "command1" "command2"
# bshtr::purge
# ```
#
# @private

bshtr::purge() {
  local tmp1 tmp2

  bshtr::assert || return 1

  tmp1="${HISTFILE}.purge.1.${$}.tmp"
  tmp2="${HISTFILE}.purge.2.${$}.tmp"

  cp "$HISTFILE" "$tmp1" || return 1

  awk "length<256" "$tmp1" > "$tmp2" || return 1
  mv "$tmp2" "$tmp1" || return 1

  if [ "${BSHTR_REMOVE:-}" ]; then
    awk "$(printf '!/%s/' "$BSHTR_REMOVE")" "$tmp1" > "$tmp2" || return 1
    mv "$tmp2" "$tmp1" || return 1
  fi

  if [ "${BSHTR_REMOVE_EXACT:-}" ]; then
    grep -v -F "$BSHTR_REMOVE_EXACT" "$tmp1" > "$tmp2" || return 1
    mv "$tmp2" "$tmp1" || return 1
  fi

  mv "$tmp1" "$HISTFILE" || return 1
}

# Removes duplicate lines from history file.
#
# ```
# bshtr::dedupe
# ```
#
# @private

bshtr::dedupe() {
  local tmp1 tmp2

  bshtr::assert || return 1

  tmp1="${HISTFILE}.dedupe.1.${$}.tmp"
  tmp2="${HISTFILE}.dedupe.2.${$}.tmp"

  cp "$HISTFILE" "$tmp1" || return 1
  awk 'NR==FNR && !/^#/{lines[$0]=FNR;next} lines[$0]==FNR' "$tmp1" "$tmp1" > "$tmp2" || return 1
  rm "$tmp1" || return 1
  mv "$tmp2" "$HISTFILE" || return 1
}

# Prune history.
#
# Trims the `$HISTFILE` to the `$HISTSIZE` length, when the file hits
# `$HISTSIZE * 2`, and archives the cut off lines to `$HISTFILE.1`.
#
# ```
# bshtr::prune
# ```
#
# @private

bshtr::prune() {
  local limit lines buffer offset archive tmp1 tmp2

  bshtr::assert || return 1

  if ! [ "${HISTSIZE:-}" ] || [ "$HISTSIZE" -lt 1 ]; then
    return 1
  fi

  limit="$HISTSIZE"
  lines=$(wc -l < "$HISTFILE")
  buffer=$(("$limit" * 2))

  if ! [ "$lines" ] || [ "$lines" -lt "$buffer" ]; then
    return 0
  fi

  offset=$(("$lines" - "$limit"))
  archive="${HISTFILE}.1"
  tmp1="${HISTFILE}.prune.1.${$}.tmp"
  tmp2="${HISTFILE}.prune.2.${$}.tmp"

  cp "$HISTFILE" "$tmp1" || return 1
  head -$offset "$tmp1" >> "$archive" || return 1
  sed -e "1,${offset}d" "$tmp1" > "$tmp2" || return 1
  rm "$tmp2" || return 1
  mv "$tmp2" "$HISTFILE" || return 1
}

# Generates last-session archive.
#
# Backups is generate as `$HISTFILE.last-session`. Instead of directly writing
# to it, the history is appended to it, and duplicate lines are removed.
#
# ```
# bshtr::archive
# ```
#
# @private

bshtr::archive() {
  local file tmp1 tmp2

  bshtr::assert || return 1

  file="${HISTFILE}.last-session"
  tmp1="${file}.1.${$}.tmp"
  tmp2="${file}.2.${$}.tmp"

  touch "$file" || return 1
  cp "$HISTFILE" "$tmp1" || return 1
  cp "$file" "$tmp2" || return 1
  cat "$tmp1" >> "$tmp2" || return 1
  awk 'NR==FNR && !/^#/{lines[$0]=FNR;next} lines[$0]==FNR' "$tmp2" "$tmp2" > "$tmp1" || return 1
  rm "$tmp2" || return 1
  mv "$tmp1" "$file" || return 1
}

# Clean temporary files.
#
# @private

bshtr::clean() {
  bshtr::assert || return 1

  rm -- "${HISTFILE}."*".${$}.tmp" 2> /dev/null
}

# History callback function.
#
# @private

bshtr::run() {
  # Write history down.
  bshtr::write

  # Remove duplicate history lines.
  bshtr::dedupe

  # Remove marked command patterns.
  bshtr::purge

  # Generate last-session archive.
  bshtr::archive

  # Rotate history to reduce filesize.
  bshtr::prune

  # Clean temporary files.
  bshtr::clean
}

# Enables history control.
#
# ```
# bshtr::ignore "cd"
# bshtr::remove "pwd" ".* #"
# bshtr::on
# ```
#
# @api

bshtr::on() {
  # End here if we are not interactive.
  case "$-" in
    *i*) ;;
    *) return 0 ;;
  esac

  # We have been called.
  BSHTR_ENABLED=1

  # Append uncommitted history on logout instead of overwriting.
  shopt -s histappend

  # Ignore commands starting with space or tab, but not duplicates.
  HISTCONTROL=ignoreboth:erasedups

  # File to store history.
  if ! [ "${HISTFILE:-}" ]; then
    HISTFILE=~/.bash_history
  fi

  # Size of history buffer.
  if ! [ "${HISTSIZE:-}" ] || [ "$HISTSIZE" -lt 5000 ]; then
    HISTSIZE=5000
  fi

  # History file size limit is set high to allow our cleaner scripts to work.
  HISTFILESIZE="$(("$HISTSIZE" * 10))"

  # Timestamps are not supported by cleaner scripts.
  unset HISTTIMEFORMAT

  # Add EXIT trap.
  bshtr::trap_append bshtr::run EXIT

  # Forget alias.
  alias forget="bshtr::forget"

  # Search alias
  alias ?="bshtr::search"
}

# Disables history control.
#
# ```
# bshtr::off
# ```
#
# @api

bshtr::off() {
  # Whether it is enabled.
  [ "${BSHTR_ENABLED:-}" ] || return 1

  # Remove trap.
  bshtr::trap_remove bshtr::run EXIT

  # Unset variables.
  unset BSHTR_ENABLED
}

# Adds a trap command to the given signal.
#
# ```
# my_function () {
#  echo "Hello World!"
# }
#
# bshtr::trap_add "my_function" ":append" "EXIT"
# ```
#
# @param {string} command The command
# @param {string} [position] Either ':append' or ':prepend'
# @param {string} signal The signal
# @see bashtr::trap_prepend
# @see bashtr::trap_append
# @private

bshtr::trap_add () {
  local add position signal traps

  add="$1"
  position="$2"

  shift 2 || return 1

  for signal in "$@"; do
    traps=$(bshtr::trap_list "$signal")

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

# Prepends a trap command to the given signal.
#
# ```
# my_function () {
#   echo "Hello World!"
# }
#
# bshtr::trap_prepend "my_function" "EXIT"
# ```
#
# @param {string} command The command
# @param {string} signal The signal
# @see bshtr::trap_append
# @private

bshtr::trap_prepend () {
  bshtr::trap_add "$1" ":prepend" "${@:2}" || return 1
}

# Appends a trap command to the given signal.
#
# ```
# my_function () {
#  echo "Hello World!"
# }
#
# bshtr::trap_append "my_function" "EXIT"
# ```
#
# @param {string} command The command
# @param {string} signal The signal
# @see bshtr::trap_prepend
# @private

bshtr::trap_append () {
  bshtr::trap_add "$1" ":append" "${@:2}" || return 1
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
# bshtr::trap_remove "my_function" "EXIT"
# ```
#
# @param {string} $command The command to remove
# @param {string} $signal The signal
# @private

bshtr::trap_remove () {
  local needle signal traps

  needle="$1"

  shift || return 1

  for signal in "$@"; do
    traps="$(bshtr::trap_list "$signal")"

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
# bshtr::trap_list "EXIT"
# ```
#
# @param {string} signal The signal
# @private

bshtr::trap_list () {
  local signal traps

  for signal in "$@"; do
    traps=$(trap -p "$signal" | awk -F "'" '{print $2}')
    traps=$(printf '%s' "$traps" | sed 's/;[ \t\r\n]*$//')
    echo "$traps"
  done
}

# Main command.
#
# @api

bshtr () {
  bshtr::"$@"
  return "$?"
}
