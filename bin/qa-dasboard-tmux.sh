#!/bin/bash

START_DIR=~/src/git/qa-dashboard
SESSION_NAME=devel

function setup_pane {
    tmux send-keys -l 'workon qa-dashboard'
    tmux send-keys Enter clear Enter
}

tmux new-session -c $START_DIR -s $SESSION_NAME -n devel -d 
setup_pane

tmux split-window -t $SESSION_NAME -h -c $START_DIR
setup_pane

# start a shell with an editor session
tmux send-keys -l 'vi -p $(ls esdk/*.py | grep -Ev "(__init__|apps|admin).py")'
tmux send-keys Enter

tmux split-window -t $SESSION_NAME -c $START_DIR -v
tmux resize-pane -y 10
setup_pane

# start the development server
tmux send-keys -l 'make start ADDR=0.0.0.0:8000'
tmux send-keys Enter

tmux select-pane -U
tmux attach-session -c $START_DIR -t $SESSION_NAME
