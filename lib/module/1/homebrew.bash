# Check updates once a day.
export HOMEBREW_AUTO_UPDATE_SECS=86400

df::path -p \
  "/usr/local/opt/coreutils/libexec/gnubin" \
  "/usr/local/opt/findutils/libexec/gnubin" \
  "/usr/local/opt/gnu-sed/libexec/gnubin" \
  "/usr/local/opt/gnu-tar/libexec/gnubin" \
  "/usr/local/opt/gettext/bin" \
  "/usr/local/opt/texinfo/bin" \
  "/usr/local/opt/binutils/bin"

df::path -p -n "manpath" \
  "/usr/local/opt/coreutils/libexec/gnuman" \
  "/usr/local/opt/findutils/libexec/gnuman" \
  "/usr/local/opt/gnu-sed/libexec/gnuman" \
  "/usr/local/opt/gnu-tar/libexec/gnuman" \
  "/usr/local/opt/gettext/share/man" \
  "/usr/local/opt/texinfo/share/man"
