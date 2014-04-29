#!/bin/sh

while getopts "cdhn" opt; do
	case $opt in
		c)
			CLEAR_MESSAGES=1
			;;
		d)
			DEBUG=1
			;;
		n)
			NOP=1
			;;
		h)
			echo "usage: $0 [-c] [-h]"
			exit 0
			;;
	esac
done

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

if [ $LAST_LINE -lt $TOTAL_LINES ]; then

	LAST_LINE=$((LAST_LINE+1))
	
	if [ -z "$NOP" ]; then
		echo $TOTAL_LINES >$DATA_FILE
	fi
	
	if [ -z "$CLEAR_MESSAGES" ]; then
		echo "`tail -n +$LAST_LINE $FNOTIFY | sed 's/ / - /'`"
	fi
fi

if [ -n "$DEBUG" ]; then
	break
fi
