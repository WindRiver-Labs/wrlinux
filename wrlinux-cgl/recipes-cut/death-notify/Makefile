#  Copyright (c) 2007,2011 Wind River Systems, Inc.
#
# The right to copy, distribute or otherwise make use of this software may be
# licensed only pursuant to the terms of an applicable Wind River license
# agreement. No license to Wind River intellectual property rights is granted
# herein. All rights not licensed by Wind River are reserved by Wind River.

death-notify_NAME        = death-notify
death-notify_VERSION     = WRS
death-notify_UPSTREAM    = internal
death-notify_LICENSE     = "Wind River"
death-notify_DEPENDS     =  glibc linux 
death-notify_DESCRIPTION = The death-notify package contains a "Hello, World" program
death-notify_RPM_DEFAULT = death-notify
death-notify_RPM_ALL     = death-notify death-notify-debuginfo
death-notify_SUMMARY     = death-notify
death-notify_SUPPORTLVL  = 1
death-notify_GROUP       = System Environment/Kernel
death-notify_MD5SUM      = WINDRIVER_INTERNAL

PACKAGES += death-notify

death-notify.download:
	@$(MAKE_STAMP)

death-notify.check:
	@$(MAKE_STAMP)

death-notify.unpack:
	@set -e; \
	$(ECHO) "Copying $(death-notify_DIST) to $(death-notify_BUILD)";           \
	if test ! -d $(death-notify_DIST)/src; then		      \
		$(ECHO) "death-notify src not found in $(death-notify_DIST)/src"; \
		exit 1;                                               \
	fi;							      \
	if test ! -d $(death-notify_BUILD); then                   \
		$(MKDIR) $(death-notify_BUILD) || exit 1;          \
	fi;                                                           \
	$(CP) -r $(death-notify_DIST)/src/* $(death-notify_BUILD);
	@$(MAKE_STAMP)

death-notify.clean: death-notify.patch
	@$(call echo_action, Cleaning,$*)
	$(FAKEROOT) $(MAKE) -C $(death-notify_BUILD) $(death-notify_MAKE_OPT) clean

death-notify.config: death-notify.patch
	@$(call echo_action, No Configuration required,$*)
	@$(MAKE_STAMP)

death-notify.compile: death-notify.unpack death-notify.config
	@$(call echo_action, Compiling,$*)
	cd $(death-notify_BUILD); \
	${MAKE} CC=${TARGET_CC}
	@$(MAKE_STAMP)

death-notify.install: death-notify.compile
	cd $(death-notify_BUILD); \
	mkdir -p $(death-notify_INSTALL_DIR)/opt; \
	mkdir -p $(death-notify_INSTALL_DIR)/opt/cut; \
	mkdir -p $(death-notify_INSTALL_DIR)/opt/cut/bin; \
	cp -f death-notify $(death-notify_INSTALL_DIR)/opt/cut/bin; \
	mkdir -p $(death-notify_INSTALL_DIR)/opt/cut/script; \
	cp -f death-notify-test $(death-notify_INSTALL_DIR)/opt/cut/script;
	@$(MAKE_STAMP)

