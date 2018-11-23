#!/bin/bash

#
# Build script to build LineageOS 12.1 for the amami device
# (copy to the 'root' of the build tree)
# ----------------------------------------------------------------------


# Check parameters
case "$1" in
  test) TESTKEY=true
    ;;
  sign) TESTKEY=false
    ;;
  *) echo "usage: build_amami [test|sign]"
     echo "-------------------------------"
     echo "test - build with testkeys (insecure, but compatible)"
     echo "sign - create a signed build"
     exit
    ;;   
esac

# ----------------------------------------------------------------------
# Optional settings, adapt according to your own needs
# ----------------------------------------------------------------------
# CCache
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache12
prebuilts/misc/linux-x86/ccache/ccache -M 32G

# Anonymize Kernel metadata and build.prop
export KBUILD_BUILD_USER=android
export KBUILD_BUILD_HOST=localhost

# Out directory on SSD
export OUT_DIR_COMMON_BASE=~/out-android
# ----------------------------------------------------------------------


# Build CM 12.1
source build/envsetup.sh

# start build
if [ "$TESTKEY" = true ] ; then
    brunch amami
else
    #
    # To sign the build with your own keys, the following pre-requsites
    # must be met; otherwise, it won't work at all:
    #
    # A. You need to have you own keys in the directory ~/.android-certs
    #
    # B. If you use the OUT_DIR_COMMON_BASE env. variable, you MUST have
    #    a symlink to the 'out' directory within your build tree
    # ------------------------------------------------------------------

    # Variables
    ROMDATE=`date +%Y%m%d`
    ROMNAME="lineage-12.1-$ROMDATE-UNOFFICIAL-amami-signed.zip"
    # Dist target
    rm -rf out/dist
    breakfast amami
    if mka target-files-package dist; then
        # Sign the apks
        croot
        ./build/tools/releasetools/sign_target_files_apks -o -d ~/.android-certs \
            out/dist/*-target_files-*.zip \
            out/dist/amami-signed-target_files.zip
        # Create & sign OTA ZIP
        ./build/tools/releasetools/ota_from_target_files -k ~/.android-certs/releasekey \
            --block --backup=true \
            out/dist/amami-signed-target_files.zip \
            out/dist/amami-signed-ota_update.zip
        # 'Bacon' target
        ln -f out/dist/amami-signed-ota_update.zip out/target/product/amami/$ROMNAME
        md5sum out/target/product/amami/$ROMNAME | sed "s|out/target/product/amami/||" > out/target/product/amami/$ROMNAME.md5sum
        echo "------------------------------------------------------------"
        echo "$ROMNAME - Finished"
    fi
fi

