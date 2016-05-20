#!/bin/sh
VM_COUNT=0

if which virsh 2>&1 >/dev/null; then
	VM_COUNT=$(virsh list | grep -i running | wc -l)
fi

if which lxc 2>&1 >/dev/null; then
	LXD_COUNT=$(lxc list 2>/dev/null | grep -i running | wc -l)
fi

if which lxc-ls 2>&1 >/dev/null; then
	LXC_COUNT=$(sudo lxc-ls -f 2>/dev/null | grep -i running | wc -l)
fi


if [ $((VM_COUNT+LXD_COUNT+LXC_COUNT)) -eq 0 ]; then
	exit 0
else
	echo "It is *NOT* safe to reboot"
	echo "=========================="
	echo "VM_COUNT=$VM_COUNT"
	echo "LXD_COUNT=$LXD_COUNT"
	echo "LXC_COUNT=$LXC_COUNT"
	exit 1
fi
