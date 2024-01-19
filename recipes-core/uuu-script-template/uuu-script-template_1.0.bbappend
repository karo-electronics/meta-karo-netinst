inherit deploy

COMPATIBLE_MACHINE = "(mx8|mx93)"

FILESEXTRAPATHS:prepend := "${THISDIR}/uuu-templates:"
SRC_URI = " \
    file://uuu.auto.template${@bb.utils.contains('KARO_BASEBOARD','qsbase','.${KARO_BASEBOARD}','',d)} \
"
LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://uuu.auto.template${@bb.utils.contains('KARO_BASEBOARD','qsbase','.${KARO_BASEBOARD}','',d)};beginline=3;endline=7;md5=c977ef98526baa4c6f3f8d22bf25cd73"
LIC_FILES_CHKSUM:mx9-nxp-bsp = "file://uuu.auto.template${@bb.utils.contains('KARO_BASEBOARD','qsbase','.${KARO_BASEBOARD}','',d)};beginline=3;endline=7;md5=c977ef98526baa4c6f3f8d22bf25cd73"

S = "${WORKDIR}"

FILES:${PN} = "uuu.auto.template"

do_install[noexec] = "1"

do_deploy () {
    install -vD ${S}/uuu.auto.template${@bb.utils.contains('KARO_BASEBOARD','qsbase','.${KARO_BASEBOARD}','',d)} ${DEPLOYDIR}/uuu.auto.template
}
addtask deploy after do_compile
