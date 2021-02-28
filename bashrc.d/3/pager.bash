if [ "$(command -v less)" ]; then
  export GIT_PAGER=less
  export LESS=FRX
  export PAGER=less
fi
