#!/bin/sh
TC_PATH=`dirname $0`
TC_SCRIPT=`basename $0`
DATA=$TC_PATH
KERNEL_VERSION=`uname -r`

function pre_environment_check
{
        [ -e $TC_PATH/config ] && rm $TC_PATH/config
        [ -r /proc/config.gz -o -r /boot/config-$KERNEL_VERSION ] || {
                echo "FATAL: missing file /proc/config.gz"
                exit $TEST_RETVAL_FAIL
        }
        [ -d /proc ] || {
                echo "FATAL: missing /proc directory"
                exit $TEST_RETVAL_FAIL
        }
        which gunzip >& /dev/null || {
                echo "FATAL: gunzip not found"
                exit $TEST_RETVAL_FAIL
        }
}


function generate_kernel_cfg
{
        pre_environment_check
        [ -r /proc/config.gz ] && cp /proc/config.gz $TC_PATH/ && gunzip $TC_PATH/config.gz
        [ -r /boot/config-$KERNEL_VERSION ] && cp /boot/config-$KERNEL_VERSION $TC_PATH/config
}


generate_kernel_cfg
if cat $TC_PATH/config | grep CONFIG_CAVIUM_OCTEON_USB=m >> /dev/null;then
modprobe octeon_usb_host
sleep 10
fi

DEVARRAY=$(find /dev -name [a-z][d,f,m][a-z] -type b)

rm -f ${DATA}/diskdata.list > /dev/null 2>&1

if cat /proc/devices | grep mmc > /dev/null 2>&1 && ls /dev/mmc* > /dev/null 2>&1;then
    echo /dev/mmcblk0p mmc_mmc>> ${DATA}/diskdata.list
fi

for i in ${DEVARRAY};do

    DEVPATH=$(udevadm info -q env -n ${i} | grep DEVPATH | tr "A-Z" "a-z")
    BUSNAME=$(udevadm info -q env -n ${i} | grep ID_BUS | tr "A-Z" "a-z" | sed 's/id_bus=//g' )
    SERIALNAME=$(udevadm info -q env -n ${i} | grep ID_SERIAL | tr "A-Z" "a-z")
    IDNAME=$(udevadm info -q env -n ${i} | grep ID_TYPE | tr "A-Z" "a-z")

    if [ ${i} = cf[a-z] ];then
        echo ${i} cf_cf>> ${DATA}/diskdata.list
        continue;
    fi

    if echo ${DEVPATH} | grep compact-flash > /dev/null 2>&1; then
        echo ${i} ${BUSNAME}_cf >> ${DATA}/diskdata.list
        continue;
    elif echo ${SERIALNAME} | grep cf_ > /dev/null 2>&1;then
        echo ${i} ${BUSNAME}_cf >> ${DATA}/diskdata.list
        continue;
    fi	

    if echo ${SERIALNAME} | grep sd0> /dev/null 2>&1;then
        echo ${i} ${BUSNAME}_mmc >> ${DATA}/diskdata.list
       	continue;
    fi

    case ${BUSNAME} in
        usb)
        echo ${i} ${BUSNAME}_usb>> ${DATA}/diskdata.list
        ;;
        ata)
        echo ${i} ${BUSNAME}_pata_sata>> ${DATA}/diskdata.list
        ;;
        scsi)
        echo ${i} ${BUSNAME}_sata >> ${DATA}/diskdata.list
        ;;
        *)
        echo ${i} ${BUSNAME}_xxx >> ${DATA}/diskdata.list
        ;;
        esac
done
