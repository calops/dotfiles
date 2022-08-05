set fish_greeting

alias bat="bat -n --theme='Monokai Extended Light'"
alias nv="nvim"
alias ls="exa --icons"
alias ll="ls -lH --git --time-style=long-iso"
alias la="ll -a"
alias lt="ll -T"
alias copy="xclip -selection clipboard"

set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.pyenv/bin $PATH

set -gx EDITOR nvim
set -gx PAGER less -FRx --mouse
set -gx BAT_PAGER $PAGER

set -gx FZF_DEFAULT_COMMAND fd --type file --color=always
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_DEFAULT_OPTS "--ansi --preview-window noborder --preview-window 'right:50%' --preview 'bat --line-range :300 {}' --color='fg:#4b505b,bg:#fafafa,hl:#5079be' --color='fg+:#4b505b,bg+:#fafafa,hl+:#3a8b84' --color='info:#88909f,prompt:#d05858,pointer:#b05ccc' --color='marker:#608e32,spinner:#d05858,header:#3a8b84'"

set -gx GITLAB_PRIVATE_TOKEN "egSAits5ZrMtsFdYWu1q"
set -gx BW_SESSION "2rYiRw9ufd7PO8XkxOv76cTxVmk9R/tuCmRQ65+Sk3moz0qZJDLTqR6msjXGGTHo5wpj04kBkppqCvVF1ghMtQ=="

export NODE_PATH=/usr/lib/nodejs:/usr/share/nodejs                                                                                                                                                                            
# export TERM=xterm-kitty

starship init fish | source

fish_ssh_agent
eval (ssh-agent -c) > /dev/null

register-python-argcomplete --shell fish pipx | .
