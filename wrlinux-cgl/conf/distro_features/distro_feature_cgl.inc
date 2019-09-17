WRTEMPLATE_append_df-cgl = " feature/cgl-full"

KERNEL_FEATURES_append_df-cgl = " features/nfsd/nfsd-enable.scc features/ecryptfs/ecryptfs.scc cgl/cfg/dmm.scc \
                           cgl/cfg/fs/ocfs2.scc \
                           cgl/cfg/scsi_dh.scc cgl/cfg/scsi_dh_rdac.scc cgl/cfg/scsi_dh_emc.scc cgl/cfg/scsi_dh_alua.scc"
# set PREFERRED_VERSION_monit to 4.9 as monit 4.9 is under GPLv2 license
PREFERRED_VERSION_monit_df-cgl ?= "4.%"

require wrlinux-cgl-whitelist.inc
