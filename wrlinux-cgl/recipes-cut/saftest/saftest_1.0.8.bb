#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "HPI Conformance Test Suite"
DESCRIPTION = "\
	SAF Test is an open-source project serving as the \
	central location for developing and providing \
	conformance test suites for SA Forum published \
	specifications. The test suites cover both the \
	A and B version of the HPI and AIS specifications.\
	Currently HPI conformance testsuite has been \
	integrated. \
	"
HOMEPAGE = "http://saftest.sourceforge.net/"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=355f36536dcc01e402dfc786f521dc6c"
S = "${WORKDIR}/saftest"
SECTION = "apps"
DEPENDS = "openipmi openhpi"

SRC_URI = "\
	${SOURCEFORGE_MIRROR}/project/saftest/SAF%20HPI%20B.01.01/saftest_HPI-B.01.01_1.0.8/saftest_HPI-B_01_01_1_0_8.tar.gz \
	file://saftest_build.patch \
	file://saftest-fix-testfail-errors.patch \
	file://clear-random-stack-value.patch \
	file://saftest-clear-more-random-stack-variables.patch \
	file://saftest-delay-to-ensure-events-added.patch \
	file://makefile-add-ldflags.patch \
	file://0001-fix-build-failures.patch \
	file://saHpiDomainTagSet-set-correct-invalid-character.patch \
	file://0001-saftest-switch-to-python3.patch \
	"

SRC_URI[md5sum] = "af9da2a206739adfe0536aefab776289"
SRC_URI[sha256sum] = "680dc4a86539281f1afa35fbff7078bcbbe36864b8f315c39988b751244f64ba"

do_install() {
	mkdir -p ${D}/opt/${BPN}
	tar --exclude='*.c' \
           --exclude='*.cpp' \
           --exclude='*.l' \
           --exclude='*.h' \
           --exclude='*.o' \
           --exclude='*/lib*.a' \
           --exclude='Makefile*' \
           --exclude='./.pc' \
           --exclude='./patches' \
	   -C ${S} --no-same-owner -hcpf - . \
         | tar -C ${D}/opt/${BPN} --no-same-owner -xpf -
}

FILES_${PN} += "/opt/saftest"
FILES_${PN}-dbg += "/opt/saftest/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/power/saHpiResourcePowerStateGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/power/saHpiResourcePowerStateSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiResourceSeveritySet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiResourceSeveritySet/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiRptEntryGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiRptEntryGet/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiRptEntryGetByResourceId/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiRptEntryGetByResourceId/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiResourceIdGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/resource/saHpiResourceTagSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorEventMasksSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorEnableGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorEventEnableSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorThresholdsGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorEnableSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorReadingGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorTypeGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorEventMasksGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorEventEnableGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/sensor/saHpiSensorThresholdsSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiAutoExtractTimeoutSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiHotSwapPolicyCancel/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiHotSwapIndicatorStateGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiResourceInactiveSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiAutoInsertTimeoutGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiHotSwapStateGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiAutoInsertTimeoutSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiHotSwapIndicatorStateSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiResourceActiveSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiHotSwapActionRequest/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/hotswap/saHpiAutoExtractTimeoutGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorAcknowledge/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorModeSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorAdd/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorGetNext/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorDelete/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/annunciator/saHpiAnnunciatorModeGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/configuration/saHpiParmControl/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogTimeSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogEntryGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogClear/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogTimeGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogOverflowReset/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogInfoGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogEntryAdd/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogStateGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/eventlog/saHpiEventLogStateSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/alarm/saHpiAlarmAcknowledge/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/alarm/saHpiAlarmDelete/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/alarm/saHpiAlarmDelete/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/alarm/saHpiAlarmGetNext/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/alarm/saHpiAlarmGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/alarm/saHpiAlarmAdd/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/watchdogtimer/saHpiWatchdogTimerSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/watchdogtimer/saHpiWatchdogTimerGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/watchdogtimer/saHpiWatchdogTimerReset/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/control/saHpiControlSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/control/saHpiControlTypeGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/control/saHpiControlGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/version/saHpiVersionGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrFieldSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrAreaAdd/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrInfoGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrFieldDelete/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrFieldAdd/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrAreaDelete/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrFieldGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/inventory/saHpiIdrAreaHeaderGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/rdr/saHpiRdrGetByInstrumentId/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/rdr/saHpiRdrGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/reset/saHpiResourceResetStateSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/reset/saHpiResourceResetStateGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/session/saHpiSessionOpen/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/session/saHpiDiscover/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/session/saHpiDiscover/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/session/saHpiSessionClose/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/domain/saHpiDomainTagSet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/domain/saHpiDomainInfoGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/domain/saHpiDrtEntryGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/events/saHpiSubscribe/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/events/saHpiSubscribe/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/events/saHpiEventAdd/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/events/saHpiEventGet/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/events/saHpiEventGet/manual/.debug"
FILES_${PN}-dbg += "/opt/saftest/HPI-B.01.01/src/events/saHpiUnsubscribe/.debug"

# saftest/utilities includes many bash and python scripts
RDEPENDS_${PN} += "bash python3-core"
