#!/bin/bash

# 
# helper script to build TWRP for the amami device
# (Make sure to checkout the 'cm-12.1-twrp' branches first)
# ---------------------------------------------------------

source build/envsetup.sh
lunch cm_amami-eng
mka recoveryimage
