set fish_greeting

alias nv="nvim"
alias ls="exa --icons"
alias cat="bat"
alias ll="ls -lH --git --time-style=long-iso"
alias la="ll -a"
alias lt="ll -T"
alias copy="xclip -selection clipboard"

set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.pyenv/bin $PATH

set -gx EDITOR nvim

set -gx FZF_DEFAULT_COMMAND fd --type file --color=always
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_DEFAULT_OPTS "--ansi --preview-window noborder --preview-window 'right:50%' --preview 'bat --line-range :300 {}'"

set -gx STOCKLY_MAIN $HOME/stockly/Main

function smake
    if test -d "./StocklyContinuousDeployment"
        make -C './StocklyContinuousDeployment' $argv
    else
        make -C './scd' $argv
    end
end

function cdr
    if test (count $argv) -gt 0
        cd $STOCKLY_MAIN/$argv[1]
    else
        cd $STOCKLY_MAIN
    end
end
function cdr_complete
    set arg (commandline -ct)
    set saved_pwd $PWD
    builtin cd $STOCKLY_MAIN
    and complete -C"cd $arg"
    builtin cd $saved_pwd
end
complete --command cdr -f --arguments '(cdr_complete)'

if test ! -f /tmp/starship.fish
    starship init fish --print-full-init >/tmp/starship.fish
end
source /tmp/starship.fish
zoxide init fish --cmd cd | source

fish_ssh_agent
eval (ssh-agent -c) > /dev/null

source /home/calops/.nix-profile/etc/profile.d/nix.fish
source ~/.config/fish/hm-session-vars.fish
