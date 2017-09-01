IMAGE_INSTALL += "packagegroup-self-hosted"
# pseudo needs extra stuff to support the 32-bit toolchain binaries.
IMAGE_INSTALL_append_x86-64 = " \
	lib32-glibc \
	lib32-libc6-dev \
	libc6-dev \
	lib32-libgcc \
	libgcc \
	lib32-libgcc-dev \
	libgcc-dev \
"
