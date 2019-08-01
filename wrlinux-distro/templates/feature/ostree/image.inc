IMAGE_INSTALL += "${@bb.utils.contains('OSTREE_BOOTLOADER', 'u-boot', 'u-boot-uenv', '', d)}"
