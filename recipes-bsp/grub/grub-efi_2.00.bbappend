#
# Modify the build for class-native so that we can build
# with an older gcc.  All we care about for native is grub-mkimage.
#
PR .= ".fix0"

FILESEXTRAPATHS_prepend := "${THISDIR}/grub-efi:"
FILESEXTRAPATHS_prepend_class-native := "${THISDIR}/grub-efi-native:"

SRC_URI += " \
    file://0001-mmap.c-Workaround-for-grub_mmap_iterate.patch \
"

SRC_URI_append_class-native = " file://warnings.patch file://warnings2.patch file://no_mcmodel.patch"

#
# Over-ride default compile.  The recipe already only installs grub-mkimage.
# We cannot build everything with older compilers, but we can build what
# we need for class-native.  Yes, just "make grub-mkimage" should work, but
# it does not.
#
do_compile_class-native () {
    cd grub-core/gnulib
    make
    cd ../..
    make grub_script.tab.h
    make grub_script.yy.h
    make grub-mkimage
}

EFI_BOOT_PATH = "/boot/efi/EFI/BOOT"

do_install_append_class-target() {
	install -d ${D}${EFI_BOOT_PATH}/${GRUB_TARGET}-efi/
	grub-mkimage -c ../cfg -p /EFI/BOOT -d ./grub-core/ \
	           -O ${GRUB_TARGET}-efi -o ${B}/${GRUB_IMAGE} \
	           ${GRUB_BUILDIN}
	install -m 644 ${B}/${GRUB_IMAGE} ${D}${EFI_BOOT_PATH}/${GRUB_IMAGE}
	# Install the modules to grub-efi's search path
	make -C grub-core install DESTDIR=${D}${EFI_BOOT_PATH} pkglibdir=""

	# Generate startup.nsh, we have the boot info in GRUB_IMAGE, the
	# startup.nsh is only used for running GRUB_IMAGE.
cat > ${D}/boot/efi/startup.nsh <<_EOF
echo -off

echo "Running ${GRUB_IMAGE}..."
${GRUB_IMAGE}
_EOF
}

# Override the do_deploy() in oe-core.
do_deploy_class-target() {
        install -m 644 ${D}${EFI_BOOT_PATH}/${GRUB_IMAGE} ${DEPLOYDIR}
}

FILES_${PN}-dbg += "${EFI_BOOT_PATH}/${GRUB_TARGET}-efi/.debug"
FILES_${PN} += "/boot/efi/"

CONFFILES_${PN} += "${EFI_BOOT_PATH}/grub.cfg"
