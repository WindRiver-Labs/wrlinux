include wic.inc

DEPENDS += " \
    parted-native syslinux-native gptfdisk-native dosfstools-native \
    mtools-native bmap-tools-native grub-native cdrtools-native \
    btrfs-tools-native squashfs-tools-native pseudo-native \
    e2fsprogs-native util-linux-native tar-native\
"

inherit native
