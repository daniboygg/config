#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

case "${OS}" in
    Linux*)
        echo "Work in progress..."
        ;;
    Darwin*)
        brew install stow fzf neovim ripgrep hammerspoon hyperfine
        ;;
    *)
        echo "Unsupported OS: ${OS}"
        exit 1
        ;;
esac

# link dot files to proper paths
stow dotfiles -t $HOME/

# useful scripts
stow scripts/ -t $HOME/.local/bin/
if [ -d "config-sherpany/scripts/" ]; then
    echo "### Installing private config..."
    stow --dir=config-sherpany scripts/ -t $HOME/.local/bin/
fi


