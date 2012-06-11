FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}_${PV}:"

SRC_URI_append_virtclass-native = "file://exit_status.patch \
				file://strip_slash_r_feature.patch \
				file://non_blocking_read.patch \
				file://socket_command_extension.patch \
				file://restart_on_eintr.patch \
				file://no_switch_on_enter_env.patch \
				file://remove_control_m_opost.patch \
				file://no_kill_parrent.patch \
				file://exit_clean_simics.patch"

