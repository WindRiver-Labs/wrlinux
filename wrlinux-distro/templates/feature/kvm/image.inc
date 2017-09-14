# enable build out .ext3 image file, shall be useful for qemu
IMAGE_FSTYPES += "ext3"

# add qemu into build
IMAGE_INSTALL += "qemu"
IMAGE_INSTALL += "libvirt"
IMAGE_INSTALL += "libvirt-libvirtd"
IMAGE_INSTALL += "libvirt-virsh"
IMAGE_INSTALL += "socat"
