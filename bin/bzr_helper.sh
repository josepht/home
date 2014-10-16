#!/bin/bash

BASE_BZR=${BASE_BZR:='lp:~joetalbott'}
CMD=$1

usage() {
	echo "Usage: $0 CMD OPTIONS" 1>&2
	echo "" 1>&2
	echo "  Expected directory layout:" 1>&2
	echo "  bzr/<project_name>/<branch_name>/" 1>&2
	echo "" 1>&2
	echo "  Commands:" 1>&2
	echo "    push - push a personal project branch" 1>&2
	echo "    create - create a branch of the project" 1>&2
	echo "    create_personal - create a branch of the project from a personal branch" 1>&2
	echo "" 1>&2
	echo "  Environment variables used:" 1>&2
	echo "    BASE_BZR - eg. lp:~<username>" 1>&2
	echo "    BRANCH_NAME" 1>&2
	echo "    DEBUG - print debug info and command but don't run the command" 1>&2
	echo "    PROJECT_NAME" 1>&2
	echo "    PROJECT_PATH - eg. lp:<project_name>/<branch_name>" 1>&2
	echo "" 1>&2
	echo "  Command options:" 1>&2
	echo "  'push' -  [NEW_BRANCH_NAME]" 1>&2
	echo "  'create' -  [NEW_BRANCH_NAME]" 1>&2
	echo "  'create_personal' -  <EXISTING_BRANCH_NAME> [NEW_BRANCH_NAME]" 1>&2
	exit 1
}

if [ -z $CMD ]; then
	usage
fi

PROJECT_DIR=$(pwd -P)
PROJECT_NAME=${PROJECT_NAME:=$(basename $(cd .. && pwd -P))}
BRANCH_NAME=${BRANCH_NAME:=$(basename $PROJECT_DIR)}

if [ -n "$DEBUG" ]; then
	echo "PROJECT_DIR: $PROJECT_DIR"
	echo "PROJECT_NAME: $PROJECT_NAME"
	echo "BRANCH_NAME: $BRANCH_NAME"
fi

case "$CMD" in
	push)
		# push is expected to be run in a branch directory (i.e. $HOME/bzr/<project>/<branch>)
		NEW_BRANCH_NAME=$BRANCH_NAME

		if [ -n "$2" ]; then
			NEW_BRANCH_NAME=$2
		fi

		if [ -n "$DEBUG" ]; then
			echo "\$2: '$2'"
			echo "BRANCH_NAME: $BRANCH_NAME"
			echo "NEW_BRANCH_NAME: $NEW_BRANCH_NAME"
		fi

		if [ $PROJECT_NAME = "$USER" -o $PROJECT_NAME = 'bzr' ]; then
			echo "You don't seem to be in a branch directory: $(pwd)"
			exit 1
		fi

		BZR_CMD="bzr push $BASE_BZR/$PROJECT_NAME/$NEW_BRANCH_NAME"
		;;
	create | create_personal)
		# create is expected to be run in a project directory (i.e. $HOME/bzr/<project>)

		NEW_BRANCH_NAME=$2
		EXISTING_BRANCH_NAME=$NEW_BRANCH_NAME

		if [ $PROJECT_NAME != 'bzr' ]; then
			echo "You don't seem to be in a project directory: $(pwd)"
			exit 1
		fi

		PROJECT_NAME=$BRANCH_NAME
		if [ $CMD = "create_personal" ]; then
			if [ -z "$2" ]; then
				usage
			fi
			if [ -n "$3" ]; then
				NEW_BRANCH_NAME=$3
			fi
			PROJECT_PATH=${PROJECT_PATH:=$BASE_BZR/$PROJECT_NAME/$EXISTING_BRANCH_NAME}
		else
			PROJECT_PATH=${PROJECT_PATH:=lp:$PROJECT_NAME}
		fi

		if [ -n "$DEBUG" ]; then
			echo "PROJECT_PATH: $PROJECT_PATH"
		fi
		BZR_CMD="bzr branch $PROJECT_PATH $NEW_BRANCH_NAME"
		;;
	*)
		usage
		;;
esac

echo "$BZR_CMD"
if [ -z "$DEBUG" ]; then
	$BZR_CMD
fi
