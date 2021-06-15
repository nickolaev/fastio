#!/bin/bash

# enable debug output for each executed command
# to disable: set +x
set -x
# exit if any command fails
set -e

KMAJOR=$(uname -r | cut -d"." -f1)
KMINOR=$(uname -r | cut -d"." -f2)

cd /root/linux
git reset --hard v${KMAJOR}.${KMINOR}
git clean -fdx

cp include/uapi/linux/bpf.h /root/sockredir
pushd tools/bpf/bpftool
make
make install
popd
