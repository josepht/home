#!/bin/sh

if [ -n "$1" -a "$1" = "-d" ]; then
	DEBUG=1
fi

DATA_FILE=$HOME/.check_irssi.dat
FNOTIFY=$HOME/.irssi/fnotify


if [ ! -f $DATA_FILE ]; then
	LAST_LINE=0
else
	LAST_LINE=`cat $DATA_FILE`
fi

TOTAL_LINES=`wc -l $FNOTIFY | cut -d' ' -f1`

if [ -n "$DEBUG" ]; then
	echo "LAST_LINE: $LAST_LINE"
	echo "TOTAL_LINES: $TOTAL_LINES"
fi

NEW_LINES=0
if [ $LAST_LINE -lt $TOTAL_LINES ]; then

	#LAST_LINE=$((LAST_LINE+1))
	NEW_LINES=$((TOTAL_LINES-LAST_LINE))
fi

echo $NEW_LINES
