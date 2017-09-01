#
# Copyright (C) 2016 Wind River Systems Inc.
#

SUMMARY = "Tools to replace busybox"
DESCRIPTION = "Tools to replace busybox"

inherit packagegroup

BUSYBOX_REPLACE_PACKAGES ??= "\
    bc \
    bzip2 \
    coreutils \
    cpio \
    debianutils \
    dhcp-client \
    dhcp-server \
    diffutils \
    dpkg-start-stop \
    e2fsprogs \
    fbset \
    findutils \
    gawk \
    grep \
    gzip \
    ifupdown \
    iproute2 \
    iputils-ping \
    kbd \
    kmod \
    less \
    ncurses-tools \
    net-tools \
    netcat \
    patch \
    procps \
    psmisc \
    unzip \
    usleep \
    util-linux \
    util-linux-mount \
    vim-tiny \
    ${@bb.utils.contains('INCOMPATIBLE_LICENSE', 'GPLv3', '', 'wget', d)} \
    "

RDEPENDS_${PN} = "${BUSYBOX_REPLACE_PACKAGES}"
