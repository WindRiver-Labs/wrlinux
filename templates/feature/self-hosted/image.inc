IMAGE_INSTALL += "packagegroup-self-hosted"

# pseudo needs extra stuff to support the 32-bit toolchain binaries.
IMAGE_INSTALL_append_x86-64 = " \
	libc6-dev \
	libgcc \
	libgcc-dev \
"
