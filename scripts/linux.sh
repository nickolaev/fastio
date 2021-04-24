#!/bin/bash

# enable debug output for each executed command
# to disable: set +x
set -x
# exit if any command fails
set -e

KTREE="git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"

git clone ${KTREE}


