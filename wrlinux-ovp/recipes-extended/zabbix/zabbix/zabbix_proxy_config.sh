#! /bin/bash

function usage() {
    cat << EOF

Usage: ${0} [-s <server IP>] [-n <proxy hostname>]

Replace config options in ${1} with the provided values.

Options:
  -s <server IP>            specify IP address of Zabbix server
  -n <proxy hostname>       specify hostname of Zabbix proxy

EOF
}


ZABBIX_SERVER_IP=""
ZABBIX_PROXY_NAME=""

ZABBIX_PROXY_CONF="%ZABBIX_PROXY_CONF%"
ZABBIX_PROXY_SYSTEMD_NAME="%ZABBIX_PROXY_SYSTEMD_NAME%"


OPTIND=1
while getopts "h?s:n:" opt; do
    case "$opt" in
    s)
        ZABBIX_SERVER_IP=$OPTARG
        ;;
    n)
        ZABBIX_PROXY_NAME=$OPTARG
        ;;
    *)
        usage ${ZABBIX_PROXY_CONF}
        exit 0
        ;;
    esac
done
shift $((OPTIND-1))


systemctl stop ${ZABBIX_PROXY_SYSTEMD_NAME}

if [ -n "${ZABBIX_SERVER_IP}" ]; then
    sed -i "s/^Server=.*/Server=${ZABBIX_SERVER_IP}/g" ${ZABBIX_PROXY_CONF}
fi

if [ -n "${ZABBIX_PROXY_NAME}" ]; then
    sed -i "s/^Hostname=.*/Hostname=${ZABBIX_PROXY_NAME}/g" ${ZABBIX_PROXY_CONF}
fi

systemctl start ${ZABBIX_PROXY_SYSTEMD_NAME}
