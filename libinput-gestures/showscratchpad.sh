#! /bin/bash

if ! i3-msg scratchpad show; then
    cd ~
    nohup alacritty --class=scratchpad >/dev/null 2>&1 &

    while ! i3-msg scratchpad show; do : ; done
fi >/dev/null 2>&1 
