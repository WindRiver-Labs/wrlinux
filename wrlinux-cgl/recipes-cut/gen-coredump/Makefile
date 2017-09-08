#  Copyright (c) 2007,2011 Wind River Systems, Inc.
#
# The right to copy, distribute or otherwise make use of this software may be
# licensed only pursuant to the terms of an applicable Wind River license
# agreement. No license to Wind River intellectual property rights is granted
# herein. All rights not licensed by Wind River are reserved by Wind River.

gen_coredump_NAME        = gen_coredump
gen_coredump_VERSION     = WRS
gen_coredump_UPSTREAM    = internal
gen_coredump_LICENSE     = "Wind River"
gen_coredump_DEPENDS     = libstdcxx glibc 
gen_coredump_DESCRIPTION = The gen_coredump package contains a gen_coredump program
gen_coredump_RPM_DEFAULT = gen_coredump
gen_coredump_RPM_ALL     = gen_coredump gen_coredump-debuginfo
gen_coredump_SUMMARY     = gen_coredump
gen_coredump_SUPPORTLVL  = 1
gen_coredump_GROUP       = System Environment/Kernel
gen_coredump_BUILD_TYPE = debug
gen_coredump_MD5SUM      = WINDRIVER_INTERNAL

PACKAGES += gen_coredump

gen_coredump.download:
	@$(MAKE_STAMP)

gen_coredump.check:
	@$(MAKE_STAMP)

gen_coredump.unpack:
	@set -e; \
	$(ECHO) "Copying $(gen_coredump_DIST) to $(gen_coredump_BUILD)";           \
	if test ! -d $(gen_coredump_DIST)/src; then		      \
		$(ECHO) "gen_coredump src not found in $(gen_coredump_DIST)/src"; \
		exit 1;                                               \
	fi;							      \
	if test ! -d $(gen_coredump_BUILD); then                   \
		$(MKDIR) $(gen_coredump_BUILD) || exit 1;          \
	fi;                                                           \
	$(CP) -r $(gen_coredump_DIST)/src/* $(gen_coredump_BUILD);
	@$(MAKE_STAMP)

gen_coredump.clean: gen_coredump.patch
	@$(call echo_action, Cleaning,$*)
	$(FAKEROOT) $(MAKE) -C $(gen_coredump_BUILD) $(gen_coredump_MAKE_OPT) clean

gen_coredump.config: gen_coredump.patch
	@$(call echo_action, No Configuration required,$*)
	@$(MAKE_STAMP)

gen_coredump.compile: gen_coredump.unpack gen_coredump.config
	@$(call echo_action, Compiling,$*)
	cd $(gen_coredump_BUILD); \
	${MAKE} CC=${TARGET_CC}
	@$(MAKE_STAMP)

gen_coredump.install: gen_coredump.compile
	cd $(gen_coredump_BUILD); \
	mkdir -p $(gen_coredump_INSTALL_DIR)/opt; \
	mkdir -p $(gen_coredump_INSTALL_DIR)/opt/cut; \
	mkdir -p $(gen_coredump_INSTALL_DIR)/opt/cut/bin; \
	cp -f gen_coredump $(gen_coredump_INSTALL_DIR)/opt/cut/bin; \
	cp -f mthread $(gen_coredump_INSTALL_DIR)/opt/cut/bin; \
	cp -f backtrace $(gen_coredump_INSTALL_DIR)/opt/cut/bin;  \
	cp -f memtrace $(gen_coredump_INSTALL_DIR)/opt/cut/bin; 
	@$(MAKE_STAMP)

