
# The gdb.sh testcase needs gdb
# and multithreaded debugging needs libc-dbg
IMAGE_INSTALL += "gdb glibc-dbg"

# Needed by test case for STD.3.1 SCTP - Base Features
IMAGE_INSTALL += "lksctp-tools-ptest"

# the iscsi testcase needs tgt
IMAGE_INSTALL += "tgt"

# the libevent testcase needs libevent-testing
IMAGE_INSTALL += "libevent-testing"

# the openl2tp testcase needs openl2tp-ptest
IMAGE_INSTALL += "openl2tp-ptest"

# kdump CUT cases needs /boot/vmlinux
IMAGE_INSTALL += "kernel-vmlinux"
