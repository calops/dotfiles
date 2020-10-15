#! /bin/bash

if ! i3-msg scratchpad show; then
    cd ~
    nohup alacritty --class=scratchpad &

    while ! i3-msg scratchpad show; do : ; done
fi >/dev/null 2>&1 

