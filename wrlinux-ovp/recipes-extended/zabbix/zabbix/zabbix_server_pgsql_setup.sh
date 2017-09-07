#! /bin/bash

CMD=$1

ZABBIX_SERVER_DBNAME="%ZABBIX_SERVER_DBNAME%"
ZABBIX_SERVER_DBUSER="%ZABBIX_SERVER_DBUSER%"
ZABBIX_SERVER_DBPASSWORD="%ZABBIX_SERVER_DBPASSWORD%"

if [ "${CMD}" == "setup" ]; then
    sudo -u postgres psql -d ${ZABBIX_SERVER_DBNAME} -c "\l" > /dev/null 2>&1
    if [ "$?" == "0" ]; then
        echo "PostgresSQL is already configured for Zabbix Server"
        exit 0
    fi

    sudo -u postgres psql -c "create user ${ZABBIX_SERVER_DBUSER} with password '${ZABBIX_SERVER_DBPASSWORD}'"
    sudo -u postgres psql -c "create database ${ZABBIX_SERVER_DBNAME} owner ${ZABBIX_SERVER_DBUSER} template template0 encoding 'UTF8'"
    sudo -u postgres psql -c "grant all on database ${ZABBIX_SERVER_DBNAME} to ${ZABBIX_SERVER_DBUSER}"
    sudo -u postgres psql -c "grant all privileges on database ${ZABBIX_SERVER_DBNAME} to postgres"

    sudo -u ${ZABBIX_SERVER_DBUSER} psql -d ${ZABBIX_SERVER_DBNAME} -f /etc/zabbix/database/postgresql/schema.sql
    sudo -u ${ZABBIX_SERVER_DBUSER} psql -d ${ZABBIX_SERVER_DBNAME} -f /etc/zabbix/database/postgresql/images.sql
    sudo -u ${ZABBIX_SERVER_DBUSER} psql -d ${ZABBIX_SERVER_DBNAME} -f /etc/zabbix/database/postgresql/data.sql
elif [ "${CMD}" == "clean" ]; then
    sudo -u postgres psql -c "drop database ${ZABBIX_SERVER_DBNAME}"
    sudo -u postgres psql -c "drop user ${ZABBIX_SERVER_DBUSER}"
fi
