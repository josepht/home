#!/bin/sh

set -x

BZR_ROOT=$HOME/src/bzr

for PROJ in $BZR_PROJECTS; do
	cd $BZR_ROOT

	# Don't bother if the project already exists
	if [ -d $PROJ ];then
		continue
	fi

	mkdir $PROJ
	cd $PROJ
	bzr init-repo .
	bzr branch lp:$PROJ trunk
	bzr checkout --lightweight trunk current-work
done
