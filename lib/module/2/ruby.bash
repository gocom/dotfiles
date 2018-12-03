export RBENV_ROOT="$HOME/.rbenv"
export GEM_HOME="$HOME/.gems"

if [ -f "$RBENV_ROOT/completions/rbenv.bash" ]; then
  . "$RBENV_ROOT/completions/rbenv.bash"
fi

df::path -n "gempath" "$GEM_HOME"
df::path "$GEM_HOME/bin" "$RBENV_ROOT/shims"
