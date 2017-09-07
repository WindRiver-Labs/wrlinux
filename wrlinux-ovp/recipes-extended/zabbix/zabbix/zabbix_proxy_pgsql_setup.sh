#! /bin/bash

CMD=$1

ZABBIX_PROXY_DBNAME="%ZABBIX_PROXY_DBNAME%"
ZABBIX_PROXY_DBUSER="%ZABBIX_PROXY_DBUSER%"
ZABBIX_PROXY_DBPASSWORD="%ZABBIX_PROXY_DBPASSWORD%"

if [ "${CMD}" == "setup" ]; then
    sudo -u postgres psql -d ${ZABBIX_PROXY_DBNAME} -c "\l" > /dev/null 2>&1
    if [ "$?" == "0" ]; then
        echo "PostgresSQL is already configured for Zabbix Proxy"
        exit 0
    fi

    sudo -u postgres psql -c "create user ${ZABBIX_PROXY_DBUSER} with password '${ZABBIX_PROXY_DBPASSWORD}'"
    sudo -u postgres psql -c "create database ${ZABBIX_PROXY_DBNAME} owner ${ZABBIX_PROXY_DBUSER} template template0 encoding 'UTF8'"
    sudo -u postgres psql -c "grant all on database ${ZABBIX_PROXY_DBNAME} to ${ZABBIX_PROXY_DBUSER}"
    sudo -u postgres psql -c "grant all privileges on database ${ZABBIX_PROXY_DBNAME} to postgres"

    sudo -u ${ZABBIX_PROXY_DBUSER} psql -d ${ZABBIX_PROXY_DBNAME} -f /etc/zabbix/database/postgresql/schema.sql
elif [ "${CMD}" == "clean" ]; then
    sudo -u postgres psql -c "drop database ${ZABBIX_PROXY_DBNAME}"
    sudo -u postgres psql -c "drop user ${ZABBIX_PROXY_DBUSER}"
fi
