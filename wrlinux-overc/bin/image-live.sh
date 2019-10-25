INSTALL_BSP="genericx86-64"
INSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-${INSTALL_BSP}.tar.bz2"

source config-usb.sh

CONFIG_DIRS=`dirname $BASH_SOURCE`

SCREEN_GETTY_CONSOLE=ttyS0,115200

HDINSTALL_ROOTFS="${ARTIFACTS_DIR}/cube-essential-${INSTALL_BSP}.tar.bz2"

HDINSTALL_CONTAINERS="${ARTIFACTS_DIR}/cube-dom0-${INSTALL_BSP}.tar.bz2:console:vty=2 \
  ${ARTIFACTS_DIR}/cube-server-${INSTALL_BSP}.tar.bz2:console:vty=3,active:net=1:cube.admin=1:cube.device.mgr=self:mounts=bind|/lib/modules|/lib/modules;bind|/lib/firmware|/lib/firmware \
  ${ARTIFACTS_DIR}/cube-vrf-${INSTALL_BSP}.tar.bz2:net=vrf:app=/usr/bin/docker-init,/sbin/vrf-init \
"

NETWORK_DEVICE="eth+ wl+ en+"

# Add to the list of PREREQ_FILES
PREREQ_FILES="${PREREQ_FILES} ${HDINSTALL_ROOTFS} `strip_properties ${HDINSTALL_CONTAINERS}`"

export LOCAL_CUSTOM_HDD_POST_FUNCS="my_local_post_func"

my_local_post_func()
{
    #copy the HAL id&passwd from dom0 to cube-srver/cube-gw/cube-desktop
    CNS="cube-server cube-gw cube-desktop"
    for c in ${CNS}; do
        if [ -d ${TMPMNT}/opt/container/$c/rootfs ]; then
            cat ${TMPMNT}/opt/container/dom0/rootfs/var/lib/cube-cmd-server/auth.db > ${TMPMNT}/opt/container/$c/rootfs/etc/cube-cmd.auth
	    if [ $c = cube-gw ] ; then
		# cube-gw configuration
		rm -f ${TMPMNT}/opt/container/cube-gw/rootfs/etc/systemd/system/multi-user.target.wants/named.service
		ln -sf /dev/null ${TMPMNT}/opt/container/cube-gw/rootfs/etc/systemd/system/named.service
		rm -f ${TMPMNT}/opt/container/cube-gw/rootfs/etc/systemd/system/systemd-resolved.service
		ln -sf /dev/null ${TMPMNT}/opt/container/cube-gw/rootfs/etc/systemd/system/systemd-resolved.service
		ln -sf /dev/null ${TMPMNT}/opt/container/cube-gw/rootfs/etc/systemd/system/systemd-networkd.service
		ln -sf /dev/null ${TMPMNT}/opt/container/cube-gw/rootfs/etc/systemd/system/systemd-networkd.socket
	    elif [ $c = cube-server ] ; then
		# Reinstate the autostarting of systemd-resolved that the cubeit-installer disables.
		# If you remove 'cube.device.mgr=self' from cube-server in HDINSTALL_CONTAINERS then don't do this, ie. comment this line out.
		ln -sf /lib/systemd/system/systemd-resolved.service ${TMPMNT}/opt/container/cube-server/rootfs/etc/systemd/system/multi-user.target.wants/systemd-resolved.service
	    fi
	fi
    done

    
}
