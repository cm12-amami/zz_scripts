#!/bin/bash

#
# Helper script to checkout the 'cm-12.1-sepol' branch (or to checkout
# back the default 'cm-12.1' branch) for the specific repositories
#
# The cm12.1-sepol branch contains some stronger SELinux rules to
# prevent user apps from spying out the internet traffic on the phone
# -------------------------------------------------------------------

switch_branches() {
  TOPDIR=$PWD
  cd device/qcom/sepolicy
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
  cd external/sepolicy
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
  cd vendor/cm
  echo "$PWD"
  git checkout $1
  cd $TOPDIR
}

case "$1" in
  sepol) BRANCH="cm-12.1-sepol"
    ;;
  default) BRANCH="cm-12.1"
    ;;
  *) echo "usage: switch_sepol [default|sepol]"
     exit
    ;;   
esac

switch_branches $BRANCH

