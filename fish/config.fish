set fish_greeting

alias bat="bat -n --theme='Monokai Extended Light'"
alias nv="nvim"
alias ls="exa --icons"
alias ll="ls -lH --git --time-style=long-iso"
alias la="ll -la"
alias lt="ls -T"

set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.pyenv/bin $PATH

set -gx EDITOR nvim
set -gx BAT_PAGER less -iRx4

set -gx FZF_DEFAULT_COMMAND fd --type file --color=always
set -gx FZF_DEFAULT_OPTS --ansi
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

starship init fish | source
