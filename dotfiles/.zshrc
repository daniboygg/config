# custom prompt like a default linux one
PS1='%F{green}%n@%m%f:%F{blue}%~%f$ '

# use neovim as default editor
export EDITOR=nvim
# when editor is vim then bash shortcuts are changed to vim ones, restore emacs default ones
bindkey -e
# a weirde behaviour after the bindkey happens and you have to press this shortcuts twice
# so bind them like this to avoid the issue
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Fix keys for tmux/iTerm2 (explicit bindings)
bindkey '^[[3~' delete-char           # Delete
bindkey '^[[1~' beginning-of-line     # Home
bindkey '^[[4~' end-of-line           # End
bindkey '^[[5~' up-line-or-history    # PageUp
bindkey '^[[6~' down-line-or-history  # PageDown

# append commands to history file immediately (not at end of session)
precmd() {
    print -s "$history[$((HISTCMD-1))]"
}

# add local binaries to the path
export PATH="$HOME/.local/bin:$PATH"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


# add autocompletions path 
fpath=(~/.oh-my-zsh/completions $fpath)
autoload -U compinit && compinit
