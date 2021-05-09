#!/bin/bash

exec ssh-agent bash
ssh-add

set -x

cd ~/
git clone git+ssh://git@github.com/josepht/home.git

mkdir -p src/git
cd src/git
git clone git@gitlab.cee.redhat.com:brew/rh-koji-internal.git
git clone git@gitlab.cee.redhat.com:tkopecek/koji-dev.git
git clone https://pagure.io/koji.git
