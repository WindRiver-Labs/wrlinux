# Default to using OpenSSH for both SSH and sftp
IMAGE_FEATURES += "ssh-sftp-servers"
FEATURE_PACKAGES_ssh-sftp-servers ??= " \
	packagegroup-core-ssh-openssh \
	openssh-sftp-server \
	"
