#
# Copyright (C) 2013 Wind River Systems, Inc.
#

do_install_append() {
        mkdir -p ${D}/opt/cut/openais-test
	tar -C ${S}/test -hcpf - . \
	 | tar -C ${D}/opt/cut/openais-test -xpf - \
           --exclude='*.c' \
           --exclude='*.cpp' \
           --exclude='*.l' \
           --exclude='*.h' \
           --exclude='*.o' \
           --exclude='*/lib*.a' \
           --exclude='Makefile*' \
           --exclude=ballista \
           --exclude='*.pl' \
           --exclude='*.pm' \
           --exclude='*ebug*.list' \
           --exclude='*.cgi'

	# We can get QA ownership warnings if we do not do this!
	chown -R root:root ${D}/opt/cut/openais-test
}

# /etc/init.d/openais needs this
#
RDEPENDS_${PN} += "bash"

FILES_${PN}-testing += "/opt/cut/openais-test/*"
FILES_${PN}-dbg += "/opt/cut/openais-test/.debug/"
