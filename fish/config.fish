set fish_greeting

alias nv="nvim"
alias copy="xclip -selection clipboard"

set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.pyenv/bin $PATH

set -gx EDITOR nvim

set -gx SKIM_CTRL_T_COMMAND fd --color=always
set -gx SKIM_CTRL_T_OPTS "--ansi --preview '~/.config/fish/preview.sh {}'"

# Commands
command -vq xcp && alias cp="xcp"
command -vq bat && alias cat="bat"
command -vq rip && alias rm="rip"
if command -vq exa
    alias ls="exa --icons"
    alias ll="ls -lH --git --time-style=long-iso"
    alias la="ll -a"
    alias lt="ll -T"
end

bind \cp 'cd (fd . --type=directory | sk --color=always)'

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
    builtin cd $STOCKLY_MAIN 2>/dev/null
    and complete -C"cd $arg"
    builtin cd $saved_pwd
end
complete --command cdr -f --arguments '(cdr_complete)'

set SRC "/tmp/source.fish"
if test ! -f $SRC
    starship init fish --print-full-init >>$SRC
    direnv hook fish >>$SRC
    zoxide init fish --cmd cd >>$SRC
end
source $SRC

function s
    cargo run --manifest-path "$STOCKLY_MAIN/.cargo/workspace/Cargo.toml" -p "stockly_cli" --release -- $argv
end

function eol
    echo "adding missing EOLs"
    git status --short | choose 1 | rargs sed -i '$a\\' {0}
end

fish_ssh_agent
eval (ssh-agent -c) > /dev/null

source ~/.config/fish/hm-session-vars.fish

