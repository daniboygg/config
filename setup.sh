#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

OS="$(uname -s)"

step "${CYAN}" "Installing dependencies"
case "${OS}" in
    Linux*)
        sudo apt-get install -qq -y \
          stow \
          fzf \
          ripgrep \
          hyperfine \
          tmux \
          sqlitebrowser \
          unzip

        godot/install.sh

        # keyd must already be installed (not packaged for apt on Pop!_OS 22):
        # it will be available in Debian 13 based, probably supported in Pop!_OS 24
        # https://github.com/rvaiya/keyd
        if command -v keyd >/dev/null; then
            sudo cp keyd/default.conf /etc/keyd/default.conf
            sudo systemctl enable --now keyd
            sudo keyd reload
        fi
        ;;
    Darwin*)
        NONINTERACTIVE=1 brew install --quiet \
          stow \
          fzf \
          neovim \
          ripgrep \
          hammerspoon \
          hyperfine \
          git-delta \
          lazygit \
          pnpm \
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

step "${CYAN}" "Configuring dotfiles"

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

step "${GREEN}" "Done, let's go!"
