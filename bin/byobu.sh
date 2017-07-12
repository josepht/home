#!/bin/sh

ssh-agent bash -c 'ssh-add; byobu $@;'
