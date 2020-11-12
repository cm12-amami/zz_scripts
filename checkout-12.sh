#!/bin/bash

#
# Helper script to checkout all branches to cm-12.1 in a run
# ----------------------------------------------------------

list_repos() {
cat <<EOF
art
bionic
bootable/recovery
build
device/common
device/qcom/sepolicy
device/sony/amami
device/sony/msm8974-common
device/sony/rhine-common
external/aac
external/bluetooth/bluedroid
external/chromium-libpac
external/chromium_org/v8
external/giflib
external/libcxx
external/libexif
external/libhevc
external/libnfc-nci
external/libnl
external/libopus
external/libvorbis
external/libvpx
external/libxml2
external/neven
external/openssl
external/pdfium
external/ppp
external/sepolicy
external/sfntly
external/skia
external/sonivox
external/sqlite
external/svox
external/tremolo
external/wpa_supplicant_8
frameworks/av
frameworks/base
frameworks/ex
frameworks/minikin
frameworks/native
frameworks/opt/net/wifi
frameworks/opt/telephony
hardware/libhardware
hardware/ril
hardware/qcom/audio/default
hardware/qcom/display
hardware/qcom/media/default
kernel/sony/msm8974
libcore
packages/apps/Bluetooth
packages/apps/CertInstaller
packages/apps/Contacts
packages/apps/ContactsCommon
packages/apps/Dialer
packages/apps/Email
packages/apps/LockClock
packages/apps/ManagedProvisioning
packages/apps/Nfc
packages/apps/PackageInstaller
packages/apps/Settings
packages/apps/SetupWizard
packages/apps/Trebuchet
packages/apps/UnifiedEmail
packages/providers/DownloadProvider
packages/providers/MediaProvider
packages/providers/TelephonyProvider
packages/providers/UserDictionaryProvider
packages/services/Telephony
packages/services/Telecomm
system/core
system/extras/su
system/media
vendor/cm
.repo/local_manifests
EOF
}

list_qcom() {
cat <<EOF
hardware/qcom/audio-caf/msm8974
hardware/qcom/display-caf/msm8974
hardware/qcom/media-caf/msm8974
EOF
}


TOPDIR=$PWD
list_repos | while read REPO; do
    cd $REPO
    echo "$PWD"
    git checkout cm-12.1
    git pull
    cd $TOPDIR
done

cd external/freetype
echo "Exception: freetype"
git checkout cm-13.0
git pull
cd $TOPDIR

list_qcom | while read REPO; do
    cd $REPO
    echo "$PWD"
    git checkout cm-12.1-caf-8974
    git pull
    cd $TOPDIR
done
