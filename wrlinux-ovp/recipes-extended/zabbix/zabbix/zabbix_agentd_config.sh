#! /bin/bash

function usage() {
    cat << EOF

Usage: ${0} [-s <server IP>] [-a <active server IP>] [-n <agent hostname>]

Replace config options in ${1} with the provided values.

Options:
  -s <server IP>            specify IP address of Zabbix server
  -a <active server IP>     specify IP address of Active Zabbix server
  -n <agent hostname>       specify hostname of Zabbix agentd

EOF
}


ZABBIX_SERVER_IP=""
ZABBIX_SERVER_ACTIVE_IP=""
ZABBIX_AGENTD_NAME=""

ZABBIX_AGENTD_CONF="%ZABBIX_AGENTD_CONF%"
ZABBIX_AGENTD_SYSTEMD_NAME="%ZABBIX_AGENTD_SYSTEMD_NAME%"


OPTIND=1
while getopts "h?s:a:n:" opt; do
    case "$opt" in
    s)
        ZABBIX_SERVER_IP=$OPTARG
        ;;
    a)
        ZABBIX_SERVER_ACTIVE_IP=$OPTARG
        ;;
    n)
        ZABBIX_AGENTD_NAME=$OPTARG
        ;;
    *)
        usage ${ZABBIX_AGENTD_CONF}
        exit 0
        ;;
    esac
done
shift $((OPTIND-1))


systemctl stop ${ZABBIX_AGENTD_SYSTEMD_NAME}

if [ -n "${ZABBIX_SERVER_IP}" ]; then
    sed -i "s/^Server=.*/Server=${ZABBIX_SERVER_IP}/g" ${ZABBIX_AGENTD_CONF}
fi

if [ -n "${ZABBIX_SERVER_ACTIVE_IP}" ]; then
    sed -i "s/^ServerActive=.*/ServerActive=${ZABBIX_SERVER_ACTIVE_IP}/g" ${ZABBIX_AGENTD_CONF}
fi

if [ -n "${ZABBIX_AGENTD_NAME}" ]; then
    sed -i "s/^Hostname=.*/Hostname=${ZABBIX_AGENTD_NAME}/g" ${ZABBIX_AGENTD_CONF}
fi

systemctl start ${ZABBIX_AGENTD_SYSTEMD_NAME}
