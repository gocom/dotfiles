# Check updates once a day.
export HOMEBREW_AUTO_UPDATE_SECS=86400

df::path -p \
  "/opt/homebrew/bin" \
  "/opt/homebrew/opt/coreutils/libexec/gnubin" \
  "/opt/homebrew/opt/findutils/libexec/gnubin" \
  "/opt/homebrew/opt/gnu-sed/libexec/gnubin" \
  "/opt/homebrew/opt/gnu-tar/libexec/gnubin" \
  "/opt/homebrew/opt/gettext/bin" \
  "/opt/homebrew/opt/texinfo/bin" \
  "/opt/homebrew/opt/binutils/bin" \
  "/usr/local/opt/coreutils/libexec/gnubin" \
  "/usr/local/opt/findutils/libexec/gnubin" \
  "/usr/local/opt/gnu-sed/libexec/gnubin" \
  "/usr/local/opt/gnu-tar/libexec/gnubin" \
  "/usr/local/opt/gettext/bin" \
  "/usr/local/opt/texinfo/bin" \
  "/usr/local/opt/binutils/bin"

df::path -p -n "manpath" \
  "/opt/homebrew/opt/coreutils/libexec/gnuman" \
  "/opt/homebrew/opt/findutils/libexec/gnuman" \
  "/opt/homebrew/opt/gnu-sed/libexec/gnuman" \
  "/opt/homebrew/opt/gnu-tar/libexec/gnuman" \
  "/opt/homebrew/opt/gettext/share/man" \
  "/opt/homebrew/opt/texinfo/share/man" \
  "/opt/homebrew/opt/binutils/share/man" \
  "/usr/local/opt/coreutils/libexec/gnuman" \
  "/usr/local/opt/findutils/libexec/gnuman" \
  "/usr/local/opt/gnu-sed/libexec/gnuman" \
  "/usr/local/opt/gnu-tar/libexec/gnuman" \
  "/usr/local/opt/gettext/share/man" \
  "/usr/local/opt/texinfo/share/man" \
  "/usr/local/opt/binutils/share/man"
