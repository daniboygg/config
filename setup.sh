#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

case "${OS}" in
    Linux*)
        echo "Work in progress..."
        ;;
    Darwin*)
        brew install \
          stow \
          fzf \
          neovim \
          ripgrep \
          hammerspoon \
          hyperfine \
          hyperfine \
          git-delta \
          lazygit \
          rectangle

        # Configuration for rectangle, it does not use regular
        mkdir -p "${HOME}/Library/Application Support/Rectangle"
        cp rectangle/RectangleConfig.json "${HOME}/Library/Application Support/Rectangle/RectangleConfig.json"
        ;;
    *)
        echo "Unsupported OS: ${OS}"
        exit 1
        ;;
esac

# link dot files to proper paths
stow dotfiles -t "${HOME}/"

# useful scripts
stow scripts/ -t $HOME/.local/bin/

# install private config
if [ -f "config-sherpany/setup.sh" ]; then
    bash config-sherpany/setup.sh
fi
