SRCREV= "e95ed52322f15437f98dee2b27de45a7495d648c"
do_install () {
       if [ -d ${B}/${MACHINE_LS} ]; then
           install -d ${D}/uefi
           cp -r  ${B}/grub ${D}/uefi
           cp -r  ${B}/${MACHINE_LS} ${D}/uefi
       fi
}

do_deploy () {
       if [ -d ${B}/${MACHINE_LS} ]; then
           install -d ${DEPLOYDIR}/uefi
           cp -r  ${B}/grub   ${DEPLOYDIR}/uefi
           cp -r  ${B}/${MACHINE_LS} ${DEPLOYDIR}/uefi
       fi
}
