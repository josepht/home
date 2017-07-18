#!/bin/bash

START_DIR=~/src/git/qa-dashboard
SESSION_NAME=devel
WINDOW_NAME=devel
SHELL_PANE=$SESSION_NAME:$WINDOW_NAME.1
EDITOR_PANE=$SESSION_NAME:$WINDOW_NAME.2
SERVER_PANE=$SESSION_NAME:$WINDOW_NAME.3

# The left pane
tmux new-session -A -c $START_DIR -s $SESSION_NAME -n devel -d 
tmux send-keys -t $SHELL_PANE 'pipenv shell' Enter

# The top-right pane (editor)
tmux split-window -t $SESSION_NAME -h -c $START_DIR

# start a shell with an editor session
tmux send-keys -t $EDITOR_PANE \
	'vi -p $(ls esdk/*.py | grep -Ev "(__init__|apps|admin).py")' Enter

# The bottom-right pane (runserver)
tmux split-window -t $SESSION_NAME -c $START_DIR -v
tmux resize-pane -t $SERVER_PANE -y 10

# start the docker DB container
tmux send-keys -t $SERVER_PANE 'make PIPENV="" start-db-container' Enter

# start the development server
tmux send-keys -t $SERVER_PANE 'make start ADDR=0.0.0.0:8000' Enter

tmux select-pane -t $SESSION_NAME:devel.2
tmux attach-session -c $START_DIR -t $SESSION_NAME
