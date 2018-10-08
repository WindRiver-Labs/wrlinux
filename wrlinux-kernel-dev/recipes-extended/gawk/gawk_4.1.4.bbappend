# The mainline kernel ships with 'scripts/ver_linux' using
# /bin/awk, however, Yocto puts awk in /usr/bin/awk. Normally
# we would patch the kernel to reflect this change. In order
# to have linux-yocto-custom work out of the box we are instead
# adding this link as a workaround.
#
# Instead of using this approach you should adapt the patch
# found at recipes-kernel/linux/files/ver_linux-Use-usr-bin-awk-instead-of-bin-awk.patch
# to be applied to your custom kernel.

FILES_${PN} += "/bin/awk"

do_install_append() {
    install -d ${D}/bin
    ln -sf /usr/bin/awk ${D}/bin/awk
}
