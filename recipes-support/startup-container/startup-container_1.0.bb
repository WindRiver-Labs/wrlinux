SUMMARY = "Load and Run container images into Docker"
DESCRIPTION = "Load and Run container images into Docker"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI =  " \
    file://load-docker-images.service \
    file://start-container@.service \
    file://load-docker-images \
    file://run-docker-images \
    file://auto-start-containers \
"

RDEPENDS_${PN} = " \
    bash \
    docker \
"

inherit allarch systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "load-docker-images.service"

do_install () {
    install -d ${D}${libexecdir}/
    install -m 0755 ${WORKDIR}/load-docker-images ${D}${libexecdir}/
    install -m 0755 ${WORKDIR}/run-docker-images ${D}${libexecdir}/
    install -m 0755 ${WORKDIR}/auto-start-containers ${D}${libexecdir}/

    install -d ${D}${systemd_unitdir}/system/
    install -m 0664 ${WORKDIR}/load-docker-images.service ${D}${systemd_unitdir}/system
    install -m 0664 ${WORKDIR}/start-container@.service ${D}${systemd_unitdir}/system

    install -d ${D}/var/docker-images/
}

FILES_${PN} += "${systemd_unitdir}/system /var/docker-images"

inherit features_check
REQUIRED_DISTRO_FEATURES = "lat"
