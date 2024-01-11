FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://cfg/initrd.cfg \
    file://cfg/binfmt.cfg \
" 
KERNEL_FEATURES:append = " bluetooth.cfg"
KERNEL_FEATURES:append = " copro.cfg"
KERNEL_FEATURES:append = " csi-camera.cfg"
KERNEL_FEATURES:append = " imx219.cfg"
KERNEL_FEATURES:append = " ipv6.cfg"
KERNEL_FEATURES:append = " dsi83.cfg"
KERNEL_FEATURES:append = " tc358867.cfg"
KERNEL_FEATURES:append = " lvds.cfg"
KERNEL_FEATURES:append = " raspi-display.cfg"
KERNEL_FEATURES:append = " systemd.cfg"
KERNEL_FEATURES:append = " wifi.cfg"
KERNEL_FEATURES:append = " pcie.cfg"
KERNEL_FEATURES:append = " flexcan.cfg"
KERNEL_FEATURES:append = " nfs-server.cfg"
KERNEL_FEATURES:append = " binfmt.cfg"
KERNEL_FEATURES:append = " initrd.cfg"
