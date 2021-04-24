#!/bin/bash

# enable debug output for each executed command
# to disable: set +x
set -x
# exit if any command fails
set -e

KTREE="git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
KMAJOR=$(uname -r | cut -d"." -f1)
KMINOR=$(uname -r | cut -d"." -f2)

cd /root
git clone --depth 1 --branch v${KMAJOR}.${KMINOR} ${KTREE}

cp linux/include/uapi/linux/bpf.h /root/sockredir
pushd linux/tools/bpf/bpftools
make
make install
popd


