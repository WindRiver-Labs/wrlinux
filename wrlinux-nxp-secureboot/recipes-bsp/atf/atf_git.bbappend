SRCREV= "4a82c939a0211196e2b80a495f966383803753bb"

PLAT = "${MACHINE}"
PLAT_ls1088ardb-pb = "ls1088ardb"
PLAT_lx2160ardb-rev2 = "lx2160ardb"
PLATFORM_lx2160ardb-rev2 = "lx2160ardb_rev2"
ddrphyopt_lx2160ardb-rev2 = "fip_ddr_sec"

do_compile() {
    export LIBPATH="${RECIPE_SYSROOT_NATIVE}"
    install -d ${S}/include/tools_share/openssl
    cp -r ${RECIPE_SYSROOT}/usr/include/openssl/*   ${S}/include/tools_share/openssl
    if [ ! -f ${RECIPE_SYSROOT_NATIVE}/usr/bin/cst/srk.pri ]; then
       ${RECIPE_SYSROOT_NATIVE}/usr/bin/cst/gen_keys 1024
    else
       cp ${RECIPE_SYSROOT_NATIVE}/usr/bin/cst/srk.pri ${S}
       cp ${RECIPE_SYSROOT_NATIVE}/usr/bin/cst/srk.pub ${S}
    fi

    if [ "${BUILD_FUSE}" = "true" ]; then
       ${RECIPE_SYSROOT_NATIVE}/usr/bin/cst/gen_fusescr ${RECIPE_SYSROOT_NATIVE}/usr/bin/cst/input_files/gen_fusescr/${chassistype}/input_fuse_file
       fuseopt="fip_fuse FUSE_PROG=1 FUSE_PROV_FILE=fuse_scr.bin"
    fi
    if [ "${BUILD_SECURE}" = "true" ]; then
        secureopt="TRUSTED_BOARD_BOOT=1 ${ddrphyopt} CST_DIR=${RECIPE_SYSROOT_NATIVE}/usr/bin/cst"
        secext="_sec"
        bl33="${uboot_boot_sec}"
        if [ ${chassistype} = ls104x_1012 ]; then
            rcwtemp="${rcwsec}"
        else
            rcwtemp="${rcw}"
        fi
    else
        bl33="${uboot_boot}"
        rcwtemp="${rcw}"
    fi       

    if [ "${BUILD_OPTEE}" = "true" ]; then
        bl32="${DEPLOY_DIR_IMAGE}/optee/tee_${MACHINE}.bin" 
        bl32opt="BL32=${bl32}"
        spdopt="SPD=opteed" 
    fi

    if [ "${BUILD_OTA}" = "true" ]; then
        otaopt="POLICY_OTA=1"
        btype="${OTABOOTTYPE}"
    else
        btype="${BOOTTYPE}"
    fi

    if [ -f ${DEPLOY_DIR_IMAGE}/ddr-phy/ddr4_pmu_train_dmem.bin ]; then
        cp ${DEPLOY_DIR_IMAGE}/ddr-phy/*.bin ${S}/
    fi

    for d in ${btype}; do
        case $d in
        nor)
            rcwimg="${RCWNOR}${rcwtemp}.bin"
            uefiboot="${UEFI_NORBOOT}"
            ;;
        nand)
            rcwimg="${RCWNAND}${rcwtemp}.bin"
            ;;
        qspi)
            rcwimg="${RCWQSPI}${rcwtemp}.bin"
            uefiboot="${UEFI_QSPIBOOT}"
            if [ "${BUILD_SECURE}" = "true" ] && [ ${MACHINE} = ls1046ardb ]; then
                rcwimg="RR_FFSSPPPH_1133_5559/rcw_1600_qspiboot_sben.bin"
            fi
            ;;
        sd)
            rcwimg="${RCWSD}${rcwtemp}.bin"
            ;;
        emmc)
            rcwimg="${RCWEMMC}${rcwtemp}.bin"
            ;;
        flexspi_nor)
            rcwimg="${RCWXSPI}${rcwtemp}.bin"
            uefiboot="${UEFI_XSPIBOOT}"
            ;;        
        esac
            
	if [ -f "${DEPLOY_DIR_IMAGE}/rcw/${PLATFORM}/${rcwimg}" ]; then
                oe_runmake V=1 -C ${S} realclean
                oe_runmake V=1 -C ${S} all fip pbl PLAT=${PLAT} BOOT_MODE=${d} RCW=${DEPLOY_DIR_IMAGE}/rcw/${PLATFORM}/${rcwimg} BL33=${bl33} ${bl32opt} ${spdopt} ${secureopt} ${fuseopt} ${otaopt}
                cp -r ${S}/build/${PLAT}/release/bl2_${d}*.pbl ${S}
                cp -r ${S}/build/${PLAT}/release/fip.bin ${S}
                if [ "${BUILD_FUSE}" = "true" ]; then
                    cp -f ${S}/build/${PLAT}/release/fuse_fip.bin ${S}
                fi

                if [ ${MACHINE} = ls1012afrwy ]; then
                    oe_runmake V=1 -C ${S} realclean
                    oe_runmake V=1 -C ${S} all fip pbl PLAT=ls1012afrwy_512mb BOOT_MODE=${d} RCW=${DEPLOY_DIR_IMAGE}/rcw/${PLATFORM}/${rcwimg} BL33=${bl33} ${bl32opt} ${spdopt} ${secureopt} ${fuseopt} ${otaopt}
                    cp -r ${S}/build/ls1012afrwy_512mb/release/bl2_qspi${secext}.pbl ${S}/bl2_${d}${secext}_512mb.pbl
                    cp -r ${S}/build/ls1012afrwy_512mb/release/fip.bin ${S}/fip_512mb.bin
                    if [ "${BUILD_FUSE}" = "true" ]; then
                        cp -r ${S}/build/ls1012afrwy_512mb/release/fuse_fip.bin ${S}/fuse_fip_512mb.bin
                    fi
                fi
                if [ -n "${uefiboot}" -a -f "${DEPLOY_DIR_IMAGE}/uefi/${PLATFORM}/${uefiboot}" ]; then
                    oe_runmake V=1 -C ${S} realclean
                    oe_runmake V=1 -C ${S} all fip pbl PLAT=${PLAT} BOOT_MODE=${d} RCW=${DEPLOY_DIR_IMAGE}/rcw/${PLATFORM}/${rcwimg} BL33=${DEPLOY_DIR_IMAGE}/uefi/${PLATFORM}/${uefiboot} ${bl32opt} ${spdopt} ${secureopt} ${fuseopt} ${otaopt}
                    cp -r ${S}/build/${PLAT}/release/fip.bin ${S}/fip_uefi.bin
                fi
        fi
        rcwimg=""
        uefiboot=""
    done
}
