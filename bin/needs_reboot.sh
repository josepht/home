#!/bin/sh

if ls /var/run/reboot* >/dev/null 2>&1; then
    echo "reboot needed"
fi
