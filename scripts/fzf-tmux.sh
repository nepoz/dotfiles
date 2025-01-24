#!/bin/bash

target=$(find . -type d -print 2>/dev/null | fzf --height 40% --reverse)

if [[ -z "$target" ]]; then
    exit 1
fi

if [[ -n "$TMUX" ]]; then
    tmux send-keys -t "$TMUX_PANE" "cd '$target'" C-m
else
    tmux new-session -c "$target"
fi
