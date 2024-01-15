inherit deploy

require recipes-core/images/karo-image.inc

COMPATIBLE_MACHINE = "(mx8|mx93)"

SUMMARY = "Debian 12 Netinstaller"

LICENSE = "CLOSED"

IMAGE_LINGUAS = ""

IMAGE_FEATURES = "" 

IMAGE_INSTALL = "" 

do_install_initrd () {
    unzip -o ${THISDIR}/uInitrd.zip -d ${DEPLOY_DIR_IMAGE}/${BPN}/
}
addtask install_initrd after do_create_uuu_auto_script before do_build