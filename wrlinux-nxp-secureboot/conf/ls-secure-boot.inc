#
# Copyright (C) 2020 Wind River Systems, Inc.
#
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

DISTRO_FEATURES_append = " secure encap"

SECURE_PRI_KEY = "${LAYER_PATH_ls-secure-layer}/ls_key/rsa4096-sample-key/rsa-4096.pri"
SECURE_PUB_KEY = "${LAYER_PATH_ls-secure-layer}/ls_key/rsa4096-sample-key/rsa-4096.pub"

UBOOT_TFA_CONFIG_nxp-ls1043 = "ls1043ardb_tfa_defconfig"
UBOOT_TFA_SECUREBOOT_CONFIG_nxp-ls1043 = "ls1043ardb_tfa_SECURE_BOOT_defconfig"
UBOOT_LS_DTB_nxp-ls1043 = "u-boot-dtb.bin"
UBOOT_CONFIG = "tfa-secure-boot tfa"
UBOOT_CONFIG[tfa] = "${UBOOT_TFA_CONFIG},,${UBOOT_LS_DTB}"
UBOOT_CONFIG[tfa-secure-boot] = "${UBOOT_TFA_SECUREBOOT_CONFIG},,${UBOOT_LS_DTB}"

PREFERRED_PROVIDER_virtual/bootloader ?= "u-boot-qoriq"

IMAGE_BOOT_FILES_nxp-ls1043 = "Image secboot_hdrs/ls1043ardb/hdr_linux.out \
				fsl-ls1043a-rdb-sdk.dtb secboot_hdrs/ls1043ardb/hdr_dtb.out \
				ls1043ardb_boot.scr hdr_ls1043ardb_bs.out \
				ls1043ardb_dec_boot.scr secboot_hdrs/ls1043ardb/hdr_ls1043ardb_bs_dec.out"
WKS_FILE_nxp-ls1043 = "nxp-ls1043-sdimage-secure-boot.wks"
do_image_wic[depends] += "secure-boot-qoriq:do_deploy"

RCWNOR_nxp-ls1043 ?= "RR_FQPP_1455/rcw_1600"
RCWSD_nxp-ls1043 ?= "RR_FQPP_1455/rcw_1600_sdboot"
RCWNAND_nxp-ls1043 ?= "RR_FQPP_1455/rcw_1600_nandboot"

QE_UCODE_nxp-ls1043 = "iram_Type_A_LS1021a_r1.0.bin"
EXTRA_IMAGEDEPENDS_nxp-ls1043 += "fm-ucode rcw qe-ucode uefi atf ls2-phy secure-boot-qoriq"

PNWHITELIST_ls-secure-layer += 'secure-boot-qoriq'
PNWHITELIST_freescale-layer += 'cst'
PNWHITELIST_freescale-layer += 'atf'
PNWHITELIST_networking-layer += 'mbedtls'
PNWHITELIST_freescale-layer += 'uefi'
PNWHITELIST_freescale-layer += 'qe-ucode'
PNWHITELIST_freescale-layer += 'fm-ucode'
PNWHITELIST_freescale-layer += 'ls2-phy'

MACHINE_LS_nxp-ls1043 = "ls1043ardb"
