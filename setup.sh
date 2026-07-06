#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

case "${OS}" in
    Linux*)
        sudo apt-get install \
          stow \
          fzf \
          ripgrep \
          hyperfine \
          tmux \
          git-delta \
          sqlitebrowser
        ;;
    Darwin*)
        brew install \
          stow \
          fzf \
          neovim \
          ripgrep \
          hammerspoon \
          hyperfine \
          git-delta \
          lazygit \
          rectangle

        # Configuration for rectangle, it does not use regular xdg directory specification
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

# install private config
if [ -f "config-personal/setup.sh" ]; then
    bash config-personal/setup.sh
fi
