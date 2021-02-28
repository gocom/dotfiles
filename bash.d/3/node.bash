df::path "$DOTFILES_HOME/node_modules/.bin"

export NVM_DIR="$HOME/.nvm"

if [ -e "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
fi

if [ -e "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/nvm.sh"
fi

