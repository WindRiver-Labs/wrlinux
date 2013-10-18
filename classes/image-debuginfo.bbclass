#
# Copyright (C) 2012 Wind River Systems, Inc.
#
# Implement a routine that adds the referenced debuginfo (-dbg) files to a
# parallel filesystem tarball to aid in remote debugging.
#
# Note, this parallel filesystem is likely not functional by itsel.
#

rpm_collect_debuginfo_files() {
   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "Generating a companion debug filesystem..."

	# We have to do this because paths get hardcoded into the BerkleyDB
	echo "  Renaming the original image..."
	rm -rf ${INSTALL_ROOTFS_RPM}-bak
	mv ${INSTALL_ROOTFS_RPM} ${INSTALL_ROOTFS_RPM}-bak

	echo "  Setting up for the dbg image..."
	mkdir -p ${INSTALL_ROOTFS_RPM}
	cp -a ${INSTALL_ROOTFS_RPM}-bak/install ${INSTALL_ROOTFS_RPM}/.
	mkdir -p ${INSTALL_ROOTFS_RPM}/etc/
	cp -a ${INSTALL_ROOTFS_RPM}-bak/etc/rpm ${INSTALL_ROOTFS_RPM}/etc/.
	mkdir -p ${INSTALL_ROOTFS_RPM}/var/lib/
	cp -a ${INSTALL_ROOTFS_RPM}-bak/var/lib/rpm ${INSTALL_ROOTFS_RPM}/var/lib/.
	cp -a ${INSTALL_ROOTFS_RPM}-bak/var/lib/smart ${INSTALL_ROOTFS_RPM}/var/lib/.

	# Move of the scriptlet helper out of the way, we don't want it...
	mv ${WORKDIR}/scriptlet_wrapper ${WORKDIR}/scriptlet_wrapper.bak

	echo "#! /bin/bash" > ${WORKDIR}/scriptlet_wrapper
	chmod +x ${WORKDIR}/scriptlet_wrapper

	rootfs_install_complementary '*-dbg'

	echo "  Cleaning up RPM information from -dbg image"
	# Remove package manager files
	rm -rf ${INSTALL_ROOTFS_RPM}/var/lib/rpm/
	rm -rf ${INSTALL_ROOTFS_RPM}/var/lib/smart/

	rm -rf ${INSTALL_ROOTFS_RPM}/install

	echo "  Restoring original image..."
	# Restore the helper
	mv ${WORKDIR}/scriptlet_wrapper.bak ${WORKDIR}/scriptlet_wrapper

	# Move the debug filesystem to the final location
	rm -rf ${INSTALL_ROOTFS_RPM}-dbg
	mv ${INSTALL_ROOTFS_RPM} ${INSTALL_ROOTFS_RPM}-dbg

	# Restore the backup to the original location
	mv ${INSTALL_ROOTFS_RPM}-bak ${INSTALL_ROOTFS_RPM}
   fi
}

RPM_POSTPROCESS_COMMANDS_prepend = "rpm_collect_debuginfo_files ; "

ipk_collect_debuginfo_files() {
   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "Generating a companion debug filesystem..."

	echo "  Creating a backup of the image into image-dbg"
	rm -rf ${INSTALL_ROOTFS_IPK}-dbg
	mkdir -p ${INSTALL_ROOTFS_IPK}-dbg
	if [ -d ${INSTALL_ROOTFS_IPK}/etc/opkg ]; then
	   mkdir -p ${INSTALL_ROOTFS_IPK}-dbg/etc
	   cp -a ${INSTALL_ROOTFS_IPK}/etc/opkg ${INSTALL_ROOTFS_IPK}-dbg/etc/.
	fi
	mkdir -p ${INSTALL_ROOTFS_IPK}-dbg/var/lib
	cp -a ${INSTALL_ROOTFS_IPK}/var/lib/opkg ${INSTALL_ROOTFS_IPK}-dbg/var/lib/.

	INSTALL_ROOTFS_IPK_BAK=${INSTALL_ROOTFS_IPK}
	export INSTALL_ROOTFS_IPK=${INSTALL_ROOTFS_IPK}-dbg

	rootfs_install_complementary '*-dbg'

	# Restore the variable for any other users...
	export INSTALL_ROOTFS_IPK=${INSTALL_ROOTFS_IPK_BAK}
   fi
}

OPKG_POSTPROCESS_COMMANDS_append += "ipk_collect_debuginfo_files ;"

deb_collect_debuginfo_files() {
   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "Generating a companion debug filesystem..."

	echo "  Creating a backup of the image into image-dbg"
	rm -rf ${INSTALL_ROOTFS_DEB}-dbg
	mkdir -p ${INSTALL_ROOTFS_DEB}-dbg
	mkdir -p ${INSTALL_ROOTFS_DEB}-dbg/var/lib
	cp -a ${INSTALL_ROOTFS_DEB}/var/lib/dpkg ${INSTALL_ROOTFS_DEB}-dbg/var/lib/.

	INSTALL_ROOTFS_DEB_BAK=${INSTALL_ROOTFS_DEB}
	export INSTALL_ROOTFS_DEB=${INSTALL_ROOTFS_DEB}-dbg

	APT_CONFIG_BAK=${APT_CONFIG}
	export APT_CONFIG=`echo ${APT_CONFIG} | sed "s,${INSTALL_ROOTFS_DEB_BAK},${INSTALL_ROOTFS_DEB},g"`

	sed -i "s,${INSTALL_ROOTFS_DEB_BAK},${INSTALL_ROOTFS_DEB},g" \
		${APT_CONFIG}

	rootfs_install_complementary '*-dbg'

	# Restore the variable for any other users...
	export APT_CONFIG=${APT_CONFIG_BAK}
	export INSTALL_ROOTFS_DEB=${INSTALL_ROOTFS_DEB_BAK}
   fi
}

DEB_POSTPROCESS_COMMANDS_append += "deb_collect_debuginfo_files ;"

tar_debuginfo_files() {
   # Remove link name
   if [ -n "${IMAGE_LINK_NAME}" ]; then
	rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}-dbg.tar.bz2
   fi

   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "taring and compressing companion debug filesystem..."
	(cd ${IMAGE_ROOTFS}-dbg && tar -cvf ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}-dbg.rootfs.tar . && \
	 bzip2 -f ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}-dbg.rootfs.tar)

	# Generate deploy link name
	if [ -n "${IMAGE_LINK_NAME}" ]; then
	   ln -s ${IMAGE_NAME}-dbg.rootfs.tar.bz2 ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}-dbg.tar.bz2
	fi
   fi
}

IMAGE_POSTPROCESS_COMMAND_append += "tar_debuginfo_files ;"
