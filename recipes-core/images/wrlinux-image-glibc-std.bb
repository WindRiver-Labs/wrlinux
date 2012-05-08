#
# Copyright (C) 2012 Wind River Systems, Inc.
#
DESCRIPTION = "An image which approximates WRLinux 4.3 glibc-std without graphics."

LICENSE = "MIT"

PR = "r0"

inherit core-image

# wrlinux feature definitions
#
PACKAGE_GROUP_rpm-plus = "rpm rpm-common rpm-build"

PACKAGE_GROUP_core-extended = "\
    task-core-basic \
    bind \
    chkconfig \
    cracklib \
    e2fsprogs-mke2fs \
    kbd \
    ldd \
    localedef \
    mailx \
    msmtp \
    mtd-utils \
    nspr \
    pam-plugin-wheel \
    ppp \
    shared-mime-info \
    tcf-agent \
    wget \
    "

PACKAGE_GROUP_core-libs-extended = "\
    tiff \
    "

PACKAGE_GROUP_core-wr-extra = "\
    xdg-utils \
    foomatic-filters \
    cups \
    ghostscript \
    liburi-perl \
    libxml-parser-perl \
    libxml-perl \
    libxml-sax-perl \
    eglibc-localedatas \
    eglibc-gconvs \
    eglibc-charmaps \
    eglibc-binaries \
    eglibc-localedata-posix \
    eglibc-extra-nss \
    eglibc-pcprofile \
    eglibc-pic \
    eglibc-utils \
    "

PACKAGE_GROUP_core-lsb-base = "\
    task-core-sys-extended \
    task-core-db \
    task-core-misc \
    task-core-perl \
    task-core-python \
    task-core-tcl \
    task-core-lsb-perl-add \
    task-core-lsb-python-add \
    "

PACKAGE_GROUP_core-lsb-more = "\
    task-core-lsb-runtime-add \
    task-core-lsb-command-add \
    "

PACKAGE_GROUP_core-lsb-graphics-plus = "\
    task-core-lsb-graphic-add \
    jpeg \
    "

# allows root login without a password
#
IMAGE_FEATURES += "debug-tweaks"


IMAGE_FEATURES += "apps-console-core"
IMAGE_FEATURES += "ssh-server-openssh"

# wrlinux features invoked
#
IMAGE_FEATURES += "rpm-plus core-extended core-lsb-base"


# useful information while tuning filesystems
#
do_dumpo() {
    echo "Distro features:  ${DISTRO_FEATURES}"
    echo "Image features:  ${IMAGE_FEATURES}"
    echo "Image contents:  ${IMAGE_INSTALL}"
    echo "Target arch:  ${TARGET_ARCH}"
    echo "Machine arch:  ${MACHINE_ARCH}"
    echo "Packages:  ${PACKAGE_INSTALL}"
}

addtask dumpo before do_rootfs



