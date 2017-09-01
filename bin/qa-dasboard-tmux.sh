#!/bin/bash

START_DIR=~/src/git/qa-dashboard
SESSION_NAME=main
WINDOW_NAME=devel
EDITOR_PANE=$SESSION_NAME:$WINDOW_NAME.1
SERVER_PANE=$SESSION_NAME:$WINDOW_NAME.2
SHELL_PANE=$SESSION_NAME:$WINDOW_NAME.3
VENV=${VENV:-qa-dashboard}
VENV_DIR=$HOME/environments
VENV_PATH=$VENV_DIR/$VENV
PROJECT=${PROJECT:-qa-dashboard}

function setup_venv() {
	PANE=$1
	#tmux send-keys -t $PANE "source ${VENV_PATH}/bin/activate" Enter
	tmux send-keys -t $PANE "project $PROJECT" Enter
}

# The left pane
tmux new-session -A -c $START_DIR -s $SESSION_NAME -n $WINDOW_NAME -d 

# start a shell with an editor session
tmux send-keys -t $EDITOR_PANE 'make edit' Enter
#tmux send-keys -t $SHELL_PANE 'pipenv shell' Enter

# The top-right pane (deploy)
tmux split-window -t $SESSION_NAME -h -c $START_DIR
#tmux resize-pane -t $SERVER_PANE -y 10
setup_venv $SERVER_PANE

# start the docker DB container
tmux send-keys -t $SERVER_PANE 'make deploy' Enter

# The bottom-right pane (shell)
tmux split-window -t $SESSION_NAME -c $START_DIR -v
setup_venv $SHELL_PANE

tmux select-pane -t $SESSION_NAME:devel.2
tmux attach-session -c $START_DIR -t $SESSION_NAME
