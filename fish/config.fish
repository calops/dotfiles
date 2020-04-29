set fish_greeting

alias bat="bat -n --theme='Monokai Extended Light'"
alias nv="nvim"

set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.pyenv/bin $PATH

set -gx EDITOR nvim
set -gx BAT_PAGER less -iRx4

starship init fish | source
