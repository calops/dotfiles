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
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_DEFAULT_OPTS "--ansi --preview-window noborder --preview-window 'right:50%' --preview 'bat --color=always --style=grid --line-range :300 {}'"

starship init fish | source
