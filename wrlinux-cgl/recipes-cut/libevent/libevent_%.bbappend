#
# Copyright (C) 2013 Wind River Systems, Inc.
#

do_install_append() {
	install -d ${D}/opt/cut/bin/libevent
	install -d ${D}/opt/cut/bin/libevent/.libs
	install -m 0755 ${S}/test/test.sh ${D}/opt/cut/bin/libevent/
	install -m 0755 ${B}/test/.libs/* ${D}/opt/cut/bin/libevent/.libs
}

PACKAGES += "${PN}-testing"
FILES_${PN}-testing += "/opt/cut/bin"
