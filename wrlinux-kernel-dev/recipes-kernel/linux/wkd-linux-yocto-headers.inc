# If KERNEL_ALT_HEADER_DIR is configured, then we need to install a set
# of kernel headers in an alternative location.  This is often used to
# avoid providing custom include files to userspace applications.  See
# the note for futher information in the file:
#   oe-core/meta/recipes-kernel/linux-libc-headers/linux-libc-headers.inc
#
# Note, we explicitly PREVENT it from being set to '/usr', as this will
# create a packaging conflict.

#KERNEL_ALT_HEADER_DIR ?= "/usr-alt"

PACKAGES += "kernel-extra-headers-misc"
DESCRIPTION_kernel-extra-headers-misc = "Set of misc/custom userspace headers."
KERNEL_MODULE_DEPEND_BLACKLIST = " kernel-extra-headers-misc"

FILES_kernel-extra-headers-misc = "${KERNEL_ALT_HEADER_DIR}"

do_install_append() {
	if [ -n "${KERNEL_ALT_HEADER_DIR}" ]; then
		if [ "${KERNEL_ALT_HEADER_DIR}" != "${exec_prefix}" ]; then
			make headers_install INSTALL_HDR_PATH=${D}${KERNEL_ALT_HEADER_DIR}

			# remove export artifacts
			find ${D}${KERNEL_ALT_HEADER_DIR} -name .install -exec rm {} \;
			find ${D}${KERNEL_ALT_HEADER_DIR} -name ..install.cmd -exec rm {} \;

			for f in ${KERNEL_INSTALL_HEADER}; do
				src_file="${S}/include/$f"
				dest_path="${D}${KERNEL_ALT_HEADER_DIR}/include/$f"

				if [ -a ${src_file} ]; then
					install -d ${dest_path%/*}
					cp -Rn $src_file ${dest_path%/*}
					echo $f >> ${D}${KERNEL_ALT_HEADER_DIR}/kernel_install_header.manifest
				else
					echo "WARNING: header file/directory not found: $f"
				fi
			done
		else
			# This configuration is NOT allowed!
			echo "ERROR: KERNEL_ALT_HEADER_DIR may not be '/usr', as this conflicts with the system headers"
			exit 1
		fi
	fi
}

sysroot_stage_all_append() {
	if [ -n "${KERNEL_ALT_HEADER_DIR}" -a "${KERNEL_ALT_HEADER_DIR}" != "${exec_prefix}" ]; then
		sysroot_stage_dir ${D}${KERNEL_ALT_HEADER_DIR} ${SYSROOT_DESTDIR}${KERNEL_ALT_HEADER_DIR}
	fi
}
