#!/bin/bash

#
# Helper script to checkout the 'cm-12.1-twrp' branches of specific
# device repositories to be able to build TWRP (or to switch back to
# default 'cm-12.1' to perform a regular build
# ------------------------------------------------------------------

switch_branches() {
  TOPDIR=$PWD
  cd device/sony/amami
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
  cd device/sony/rhine-common
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
  cd device/sony/msm8974-common
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
  cd .repo/local_manifests
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
}

case "$1" in
  twrp) BRANCH="cm-12.1-twrp"
    ;;
  default) BRANCH="cm-12.1"
    ;;
  *) echo "usage: switch_twrp [default|twrp]"
     exit
    ;;   
esac

switch_branches $BRANCH

