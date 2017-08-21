#!/bin/sh

tmux new-session -s 'devel' -n "devel"
tmux -2 attach-session -d
