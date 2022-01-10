FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"

SRCREV = "ba20d1597265070ea934353662d7d86ab395cefe"
SRC_URI = "git://github.com/OpenSCAP/scap-security-guide.git;branch=master;protocol=https \
           file://0001-Add-the-WRLinux-LTS21-product.patch \
          "

PV = "0.1.59"

EXTRA_OECMAKE += "-DSSG_PRODUCT_CHROMIUM=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_DEBIAN9=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_DEBIAN10=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_DEBIAN11=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_FEDORA=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_FIREFOX=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_FUSE6=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_JRE=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_MACOS1015=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OCP4=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OL7=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OL8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OPENSUSE=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHCOS4=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHEL7=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHEL8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHEL9=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHOSP10=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHOSP13=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHV4=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_SLE12=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_SLE15=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_UBUNTU1604=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_UBUNTU1804=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_UBUNTU2004=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_VSEL=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_WRLINUX8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_WRLINUX1019=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_WRLINUXLTS21=ON"
