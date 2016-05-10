#!/bin/sh

if [ -z "$1" ];then
	echo "Usage '$0 <host>'"
	exit 1
fi

# Define SSH_LOCAL_HOSTS in your environment with a regex pattern that
# matches your .local hosts.
# eg. SSH_HoSTS='^(apple|orange)$' to match 'apple' or 'orange'
if [ -n "$SSH_LOCAL_HOSTS" ] && (echo "$1" | grep -Eq "$SSH_LOCAL_HOSTS"); then
	HOST=$1.local
else
	HOST=$1
fi

if [ -z "$HOST" ]; then
	echo 'Missing host'
	exit 1
fi

ssh -AYt $HOST byobu
