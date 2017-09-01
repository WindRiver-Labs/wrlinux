IMAGE_INSTALL += "kernel-image"
IMAGE_INSTALL += "grub"
IMAGE_INSTALL += "grubby"
IMAGE_INSTALL += "shadow"
IMAGE_INSTALL += "efibootmgr"

# Need run depmod on the target
IMAGE_INSTALL += "kmod"

# Busybox's mount doesn't support some options,
# that caused fs mount failed on glibc-small image,
# use util-linux-mount to instead.
IMAGE_INSTALL += "util-linux-mount"

IMAGE_INSTALL += "init-ifupdown"

IMAGE_INSTALL += "libuser"

IMAGE_INSTALL += "dracut"

IMAGE_INSTALL += "cryptsetup"

# The grub-mkconfig requires them to generate target grub.cfg
IMAGE_INSTALL += "sed grep"

# The blevet requires them for EFI.
IMAGE_INSTALL += "dosfstools e2fsprogs"
IMAGE_INSTALL += "${@bb.utils.contains('INCOMPATIBLE_LICENSE', 'GPLv3', '', 'grub-efi', d)}"

# The btrfs partition requires it
IMAGE_INSTALL += "btrfs-tools"

EXTRA_IMAGEDEPENDS += "glibc-locale"

# Generate filesystem images for image copy install
IMAGE_FSTYPES += "ext4"

IMAGE_POSTPROCESS_COMMAND_append = " emit_image_env;"

python emit_image_env () {
    localdata = bb.data.createCopy(d)

    # Export DISTRO for installer build
    localdata.setVarFlag("DISTRO", "unexport", "")

    dumpfile = d.expand("${T}/target_image_env")
    with open(dumpfile , "w") as f:
        bb.data.emit_env(f, localdata, True)
}
