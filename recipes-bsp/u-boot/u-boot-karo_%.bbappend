FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/cfg:"

SRC_URI:append = " \
    file://legacy-image.cfg \
" 
UBOOT_FEATURES:append = " legacy-image"
