reformat_rootfs() {
    if [ -z "${IMAGE_PARTITION_MOUNTPOINT}" ];then
        bbfatal "IMAGE_PARTITION_MOUNTPOINT is not set for '${SUBIMAGE_NAME}'"
    fi
    rm -rf "${WORKDIR}/${SUBIMAGE_NAME}"
    if [ -d ${IMAGE_ROOTFS}${IMAGE_PARTITION_MOUNTPOINT} ]; then
        mv "${IMAGE_ROOTFS}${IMAGE_PARTITION_MOUNTPOINT}" "${WORKDIR}/${SUBIMAGE_NAME}"
        mv "${IMAGE_ROOTFS}/lib/modules" "${WORKDIR}/${SUBIMAGE_NAME}"
        rm -r "${IMAGE_ROOTFS}"
        mv "${WORKDIR}/${SUBIMAGE_NAME}" "${IMAGE_ROOTFS}"
    else
        rm -rf "${IMAGE_ROOTFS}"/*
    fi
} 

EXTRA_IMAGECMD:ext4 += " -U e3ac4b41-9b96-4886-8ef9-8acff7504f29 " 