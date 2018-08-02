# Force the name, we don't want ?= or our SDK naming will be used.
TOOLCHAIN_OUTPUTNAME_osv-wrlinux = "${SDK_ARCH}-buildtools-nativesdk-standalone-${DISTRO_VERSION}"

# for toaster
#
TOOLCHAIN_HOST_TASK_append_osv-wrlinux = " \
      nativesdk-python3-django nativesdk-python3-django-south \
      nativesdk-python3-numbers nativesdk-python3-email \
      nativesdk-python3-html nativesdk-python3-resource \
      nativesdk-python3-debugger \
      nativesdk-python3-pytz nativesdk-python3-beautifulsoup4 \
      nativesdk-libgcc \
     "

# use anspass to save and retrieve credentials
TOOLCHAIN_HOST_TASK_append_osv-wrlinux = " nativesdk-anspass"

SDK_POSTPROCESS_COMMAND_prepend_osv-wrlinux = " gen_buildtools_delete_target ;"

gen_buildtools_delete_target() {
	rm -rf ${SDK_OUTPUT}/${SDKTARGETSYSROOT}
}
