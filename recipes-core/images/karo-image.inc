LICENSE = "MIT"

inherit core-image features_check rootfs-postprocess
require ${@ "karo-nxp.inc" if 'use-nxp-bsp' in d.getVar('MACHINEOVERRIDES').split(':') else "karo-mainline.inc"}

inherit extrausers
EXTRA_USERS_PARAMS ?= "usermod -p '' root"

REQUIRED_DISTRO_FEATURES ??= ""

IMAGE_INSTALL:append = " kernel-modules"
DEPENDS:append:mx8m-nxp-bsp = " u-boot-karo"
DEPENDS:append:mx9-nxp-bsp = " imx-boot-karo"
DEPENDS:append:use-nxp-bsp = " uuu-script-template"

PREFERRED_PROVIDER_fdisk = "util-linux"

IMAGE_OVERHEAD_FACTOR = "1"
IMAGE_ROOTFS_SIZE ?= "${@${ROOTFS_PARTITION_SIZE}-(${IMAGE_ROOTFS_EXTRA_SPACE})}"

IMAGE_FSTYPES:append = "${@bb.utils.contains('MACHINE_FEATURES',"emmc"," ext4","",d)}"

# mkfs.ext4 parameters
# set inode size to 256 to support timestamps beyond 2038-01-19
EXTRA_IMAGECMD:ext4 += "-I 256"

PARTITION_NAMES[bootfs] ?= "boot"

def get_part_info(d, partlist, index):
    if d.getVar('ROOTFS_PARTITION_INDEX') != None:
        rootfs_partition_index = d.getVar('ROOTFS_PARTITION_INDEX')
    else:
        rootfs_partition_index = 1

    lastpart = index == len(partlist)

    if index == rootfs_partition_index:
        partname = "rootfs"
        image = d.getVar('BPN')
    else:
        i = index if index < rootfs_partition_index else index - 1
        partname = partlist[i]
        image = "karo-image-%s" % partname

    if partname in d.getVarFlags('IMAGE_ROOTFS_SIZE'):
        size = d.getVarFlags('IMAGE_ROOTFS_SIZE')[partname]
    elif d.getVar(partname.upper() + "_PARTITION_SIZE"):
        size = d.getVar(partname.upper() + "_PARTITION_SIZE")
    elif index == rootfs_partition_index:
        size = d.getVar('IMAGE_ROOTFS_SIZE')
    elif not lastpart:
        bb.fatal("Cannot determine size for partition '%s'" % partname)

    if lastpart:
        size = "MAX"
    elif size.isnumeric():
        size = size + "KiB"

    if d.getVarFlags('PARTITION_NAMES') and partname in d.getVarFlags('PARTITION_NAMES'):
        partname = d.getVarFlag('PARTITION_NAMES', partname, True)

    bb.note("partition[%s]='%s'" % (partname, size))
    return (partname, image, size)
