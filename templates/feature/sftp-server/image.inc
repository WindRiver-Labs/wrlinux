# Default to using OpenSSH for both SSH and sftp
IMAGE_FEATURES += "ssh-server-openssh"
IMAGE_INSTALL += " \
    openssh-sftp-server \
"
