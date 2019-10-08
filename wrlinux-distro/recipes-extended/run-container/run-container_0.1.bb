SUMMARY = "Imports container images into Docker"
DESCRIPTION = "Imports container images listed in containers_to_run.txt into Docker and instructs Docker to run them."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI =  " \
    file://containers.conf \
    file://run_container.sh \
    file://run_container.service \
    file://run-ptest \
"

inherit allarch ptest systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "run_container.service"

python do_install () {
    bb.build.exec_func('do_install_base', d)
    bb.build.exec_func('write_containers_conf', d)
}

do_install_base () {
    install -d ${D}${libexecdir}/${BPN}
    install -m 0755 ${WORKDIR}/run_container.sh ${D}${libexecdir}/${BPN}/

    install -d ${D}${systemd_unitdir}/system/
    install -m 0664 ${WORKDIR}/run_container.service ${D}${systemd_unitdir}/system

    install -d ${D}${sysconfdir}/wr-containers
    install -m 0644 ${WORKDIR}/containers.conf ${D}${sysconfdir}/wr-containers
}

python write_containers_conf () {
    configs = {}
    for k in d:
        if k.startswith('WR_DOCKER_PARAMS') or k.startswith('WR_DOCKER_START_COMMAND'):
            configs[k] = d.getVar(k)

    if configs:
        conf_file = oe.path.join(d.getVar('D'), d.getVar('sysconfdir'), 'wr-containers/containers.conf')
        with open(conf_file, 'a') as f:
            for k in configs:
                f.write('%s="%s"\n' % (k, configs[k]))
}

do_install[nostamp] = "1"

RDEPENDS_${PN} = "bash docker"

EXCLUDE_FROM_WORLD = "1"
