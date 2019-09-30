#
# Copyright (C) 2019 Wind River Systems, Inc.
#
# used by template feature/run-container

python check_container_config () {
    if d.getVar('BB_CURRENT_MC') == 'default':
        return

    containers = d.getVar('CONTAINER_NAMES')
    priorities = d.getVar('CONTAINER_PRIORITIES')
    host_images = d.getVar('HOST_IMAGES')

    if not (host_images and containers and priorities):
        bb.fatal('Please set CONTAINER_NAMES, CONTAINER_PRIORITIES and HOST_IMAGES correctly.')

    if len(containers.split()) != len(priorities.split()):
        bb.fatal('CONTAINER_NAMES and CONTAINER_PRIORITIES are associated, please set them correctly.')

    common = set(containers.split()).intersection(set(host_images.split()))
    if common:
        bb.fatal('Recipe(s) %s not allowed set both in CONTAINER_NAMES and HOST_IMAGES.' % ' '.join(common))
}

addhandler check_container_config
check_container_config[eventmask] = "bb.event.ConfigParsed"

# handle settings of hosts
python () {
    if d.getVar('BB_CURRENT_MC') != 'wr-host':
        return

    pn = d.getVar('PN')
    host = d.getVar('HOST_IMAGES').split()
    if pn in host:
        d.appendVar('IMAGE_INSTALL', ' run-container')

        containers = d.getVar('CONTAINER_NAMES').split()
        d.appendVarFlag('do_rootfs', 'mcdepends', ' '.join(['multiconfig:wr-host:wr-container:%s:do_image_complete' % c for c in containers]))

        d.appendVar('ROOTFS_POSTPROCESS_COMMAND', ' rootfs_install_container;')
}

rootfs_install_container () {
    install -d ${IMAGE_ROOTFS}${CONTAINER_DEST_ON_HOST}

    for container in ${CONTAINER_NAMES}
    do
        image=`ls -1t ${TOPDIR}/tmp-container${TCLIBCAPPEND}/deploy/images/${MACHINE}/${container}*tar.bz2 | head -1`
        install ${image} ${IMAGE_ROOTFS}${CONTAINER_DEST_ON_HOST}
    done

    install -d ${IMAGE_ROOTFS}/etc/wr-containers
    touch ${IMAGE_ROOTFS}/etc/wr-containers/containers_to_run.txt

    echo "${CONTAINER_NAMES}" >> ${IMAGE_ROOTFS}/etc/wr-containers/containers_to_run.txt
    echo "${CONTAINER_PRIORITIES}" >> ${IMAGE_ROOTFS}/etc/wr-containers/containers_to_run.txt
    echo -n "${CONTAINER_DEST_ON_HOST}" >> ${IMAGE_ROOTFS}/etc/wr-containers/containers_to_run.txt
}
