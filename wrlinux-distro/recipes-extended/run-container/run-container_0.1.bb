SUMMARY = "Imports container images into Docker"
DESCRIPTION = "Imports container images listed in containers_to_run.txt into Docker and instructs Docker to run them."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI =  " \
    file://run_container.sh \
    file://run_container.service \
    file://run-ptest \
"

inherit allarch ptest systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "run_container.service"

do_install () {
    install -d ${D}${libexecdir}/${BPN}
    install -m 0755 ${WORKDIR}/run_container.sh ${D}${libexecdir}/${BPN}/

    install -d ${D}${systemd_unitdir}/system/
    install -m 0664 ${WORKDIR}/run_container.service ${D}${systemd_unitdir}/system
}

RDEPENDS_${PN} = "bash docker"

EXCLUDE_FROM_WORLD = "1"
