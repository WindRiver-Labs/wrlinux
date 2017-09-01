# Force the name, we don't want ?= or our SDK naming will be used.
TOOLCHAIN_OUTPUTNAME = "${SDK_ARCH}-buildtools-nativesdk-standalone-${DISTRO_VERSION}"

# for toaster
#
TOOLCHAIN_HOST_TASK += \
     "nativesdk-python3-django nativesdk-python3-django-south \
      nativesdk-python3-numbers nativesdk-python3-email \
      nativesdk-python3-html nativesdk-python3-resource \
      nativesdk-python3-debugger \
      nativesdk-libgcc \
     "

# use anspass to save and retrieve credentials
TOOLCHAIN_HOST_TASK += "nativesdk-anspass"

SDK_POSTPROCESS_COMMAND_prepend = "gen_buildtools_delete_target ;"

gen_buildtools_delete_target() {
	rm -rf ${SDK_OUTPUT}/${SDKTARGETSYSROOT}
}
