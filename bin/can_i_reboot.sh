#!/bin/sh

VM_COUNT=$(virsh list | grep -i running | wc -l)
LXD_COUNT=$(lxc list | grep -i running | wc -l)
LXC_COUNT=$(sudo lxc-ls -f | grep -i running | wc -l)


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
