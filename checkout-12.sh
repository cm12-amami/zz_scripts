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
external/libnl
external/libhevc
external/libnfc-nci
external/libopus
external/libvorbis
external/libvpx
external/libxml2
external/neven
external/openssl
external/pdfium
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
kernel/sony/msm8974
libcore
packages/apps/Bluetooth
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
system/core
system/extras/su
system/media
vendor/cm
EOF
}

TOPDIR=$PWD
list_repos | while read REPO; do
    cd $REPO
    echo "$PWD"
    git checkout cm-12.1
    cd $TOPDIR
done
