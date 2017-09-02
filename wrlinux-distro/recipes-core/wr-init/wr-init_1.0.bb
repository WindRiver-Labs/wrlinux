DESCRIPTION = "Basic rc.local facility for wrlinux"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

SRC_URI = "file://rc.local.example \
           file://rcinit" 

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "rcinit"
INITSCRIPT_PARAMS = "start 999 2 3 4 5 ."

do_install () {
    install -d ${D}/${sysconfdir}/
    install -m 755 ${S}/rc.local.example ${D}/${sysconfdir}/rc.local
    if ${@bb.utils.contains('DISTRO_FEATURES','sysvinit','true','false',d)}; then
        install -d ${D}/${sysconfdir}/init.d
        install -m 755 ${S}/rcinit ${D}/${sysconfdir}/init.d/rcinit
    fi
} 

# As the recipe doesn't inherit systemd.bbclass, we need to set this variable
# manually to avoid unnecessary postinst/preinst generated.
python __anonymous() {
    if not bb.utils.contains('DISTRO_FEATURES', 'sysvinit', True, False, d):
        d.setVar("INHIBIT_UPDATERCD_BBCLASS", "1")
}
