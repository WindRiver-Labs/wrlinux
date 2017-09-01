#
# Copyright (C) 2014 Wind River Systems, Inc.
#
SUMMARY = "Microcode Control Tool"
HOMEPAGE = "https://pagure.io/microcode_ctl/"
SECTION = "console/utils"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit update-rc.d systemd

DEFAULT_PREFERENCE = "-1"

INITSCRIPT_PACKAGES = "microcode-ctl"
INITSCRIPT_NAME_microcode-ctl = "microcode_ctl"
INITSCRIPT_PARAMS_microcode-ctl = "start 80 2 3 4 5 . stop 20 0 1 6 ."

SYSTEMD_SERVICE_${PN} = "microcode_ctl.service"

COMPATIBLE_HOST = "(i.86|x86_64).*-linux"

FIRMWARE_DIR = "/lib/firmware"

EXTRA_OEMAKE = '\
                CC="${CC}" \
                'CFLAGS+=-Wall -I${STAGING_KERNEL_DIR}/include' \
               '

do_install() {
	oe_runmake install DESTDIR=${D} PREFIX=${prefix}
	rm -rf ${D}${FIRMWARE_DIR}/amd-ucode
	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/microcode_ctl.service ${D}${systemd_unitdir}/system
	sed -i -e 's,@SBINDIR@,${sbindir},g' ${D}${systemd_unitdir}/system/microcode_ctl.service
}

#there is no need to do_populate_sysroot for this package,
#otherwise, it will conflict with the linux-firmware,
#to override the default do_populate_sysroot
do_populate_sysroot[noexec] = "1"

PACKAGES += "${PN}-firmware"
FILES_${PN}-firmware = "\
    ${FIRMWARE_DIR}/microcode.dat \
"

RDEPENDS_${PN} = "${PN}-firmware bash"


