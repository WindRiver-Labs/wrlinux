#!/bin/sh

# Copyright (c) 2016 Wind River Systems, Inc.
# description : Used to setup cluster with two nodes

# Note this script cannot be run directly, but just
# a script which defines the fuctions specified for cluster
# case

# developer : Mingli Yu  <mingli.yu@windriver.com>
#

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh

TMP_DIR=`mktemp -d /tmp/cluster.tmp.XXXXXX`

HOSTNAME1=""
HOSTNAME2=""
TARGET_IP=""
# local target network address
NETADDR1=""
# client network address
NETADDR2=""
# only clean client setting when both ip_flag and autossh_f is true
ip_flag=false
autossh_f=false

clean()
{
    echo "Clean System..."
    [ -f /etc/hosts.bak ] && mv -f /etc/hosts.bak /etc/hosts
    [ -f /etc/corosync/corosync.conf.bak ] && mv -f /etc/corosync/corosync.conf.bak \
        /etc/corosync/corosync.conf
    [ -f /etc/init.d/corosync ] && service corosync stop || systemctl stop corosync
    [ -f /etc/init.d/pacemaker ] && service pacemaker stop || systemctl stop pacemaker
    
    if [ "$ip_flag" = true ]; then
        # wait for the client boots up if needed
        while true
        do
            ping -c 3 $CLIENT_IP
            if [ $? -eq 0 ]; then
                break
            fi
            sleep 10
        done
    
        # wait for the system be stable 
        sleep 10
        if [ "$autossh_f" = true ]; then
            ssh root@$CLIENT_IP -- "[ -f /etc/hosts.bak ] && mv -f /etc/hosts.bak /etc/hosts"
            ssh root@$CLIENT_IP -- "[ -f /etc/corosync/corosync.conf.bak ] && \
                mv -f /etc/corosync/corosync.conf.bak /etc/corosync/corosync.conf"
            ssh root@$CLIENT_IP -- "[ -f /etc/init.d/corosync ] && \
                service corosync stop || systemctl stop corosync"
            ssh root@$CLIENT_IP -- "[ -f /etc/init.d/pacemaker ] \
                && service pacemaker stop || systemctl stop pacemaker"
        fi
    fi
    rm -rf $TMP_DIR
    echo "Finish"
}

cus_corosync()
{
    cp /etc/corosync/corosync.conf.example /etc/corosync/corosync.conf
    check_localeth
 
    # get netmask
    netmask=`ifconfig $LOCAL_ETH | grep 'inet ' | sed 's/^.*Mask://g'`
    
    # get local target network addrss    
    NETADDR1=`get_netaddr $TARGET_IP $netmask`
    
    # get client netmask
    netmask1=`ssh root@$CLIENT_IP -- ifconfig | grep  $CLIENT_IP | sed 's/^.*Mask://g'`
    NETADDR2=`get_netaddr $CLIENT_IP $netmask1`
    
    # compare the two network address
    if [ x"$NETADDR1" != x"$NETADDR2" ]; then
        cuterr "The two host used to setup a cluster not in a same network"
    fi
    
    # customize the corosync.conf
    cp /etc/corosync/corosync.conf.example /etc/corosync/corosync.conf
   
    # update the bindnetaddr item in /etc/corosync/corosync.conf
    sed -i "s/bindnetaddr: .*$/bindnetaddr: $NETADDR1/g" /etc/corosync/corosync.conf
    
    # update the /etc/hosts and /etc/corosync/corosync.conf on client
    ssh root@$CLIENT_IP -- "cp /etc/hosts /etc/hosts.bak"
    scp /etc/hosts root@$CLIENT_IP:/etc/ || \
        cuterr "Failed to customize /etc/hosts on client"
    scp /etc/corosync/corosync.conf root@$CLIENT_IP:/etc/corosync/ || \
        cuterr "Failed to customize /etc/corosync/corosync.conf on client"
}

check_service()
{
   if [ $# -lt 1 ]; then
       return
   else
       if [ -f /etc/init.d/$1 ]; then
           service $1 status | grep "is running" || cuterr "$1 not running"
       else
           systemctl status $1 | grep "Active: active" || cuterr "$1 not running"
       fi
   fi
}

# set up a cluster with two hosts
setup_cluster()
{
    valid_clientip
    ip_flag=true
    autossh $CLIENT_IP
    autossh_f=true

    # customize the hosts file
    HOSTNAME1=`hostname`
    HOSTNAME2=`ssh root@$CLIENT_IP -- hostname`
    TARGET_IP=`get_targetip`
    cus_hosts $HOSTNAME1 $TARGET_IP $HOSTNAME2 $CLIENT_IP
    
    cus_corosync
    # start corosync and pacemaker
    [ -f /etc/init.d/corosync ] && service corosync start || systemctl start corosync
    
    # wait for service to be stable
    sleep 5
    check_service corosync
    
    [ -f /etc/init.d/pacemaker ] && service pacemaker start || systemctl start pacemaker
    
    # wait for service to be stable
    sleep 5
    check_service pacemaker
    ssh root@$CLIENT_IP -- "[ -f /etc/init.d/corosync ] && service corosync start || systemctl start corosync"
    ssh root@$CLIENT_IP -- "[ -f /etc/init.d/pacemaker ] && service pacemaker start || systemctl start pacemaker"
    
    # wait a moment to get the service be stable
    sleep 30

    # check the service on client
    ssh root@$CLIENT_IP -- "[ -f /etc/init.d/corosync ] && service corosync status|\
        grep 'is running' || systemctl status corosync | grep 'Active: active'"
    [ $? -ne 0 ] && cuterr "corosync not running on the client"
    
    ssh root@$CLIENT_IP -- "[ -f /etc/init.d/pacemaker ] && service pacemaker status|\
        grep 'is running' || systemctl status pacemaker | grep 'Active: active'"
    [ $? -ne 0 ] && cuterr "pacemaker not running on the client"
}

clean_apache()
{
    # clean the cluster setting
    crm configure show|grep "colocation website-with-ip inf"
    if [ $? -eq 0 ]; then
        crm configure delete website-with-ip
    fi
    crm configure show|grep "primitive WebSite apache"
    if [ $? -eq 0 ]; then
        crm resource stop WebSite
        sleep 10
        crm configure delete WebSite
    fi
    crm configure show|grep "primitive ClusterIP IPaddr2"
    if [ $? -eq 0 ]; then
        crm resource stop ClusterIP
        sleep 10
        crm configure delete ClusterIP
    fi
}


start_web()
{
    # Hint: you need to configure CLUSTER_IP under
    # /opt/cut/env/runtime_env
    valid_ip $CLUSTER_IP
    ret=$?
    if [ $ret -eq 1 ]; then
        echo "Error: Empty cluster ip."
        echo "Note: This test case requires two targets to"
        echo "setup a cluster and need to set CLUSTER_IP which"
        echo "is not used by any actual interface and must be"
        echo "in the same network with client and local target."
        echo "Please set CLUSTER_IP in /opt/cut/env/runtime_env"
        echo "before running the test script, or it will always fail."
        cutfail
    elif [ $ret -eq 2 ]; then
        cuterr "Invalid cluster ip"
    fi
    
    # disable stonith as we don't configure stonith device here
    crm configure property stonith-enabled=false

    # clean the cluster setting
    clean_apache
    
    # configure cluster and website resource
    crm configure primitive ClusterIP ocf:heartbeat:IPaddr2 params ip=${CLUSTER_IP} cidr_netmask=32 op monitor interval=30s 
    crm configure property no-quorum-policy=ignore
    
    # update index.html
    cp /usr/share/apache2/default-site/htdocs/index.html \
    /usr/share/apache2/default-site/htdocs/index.html.bak
cat <<-END >/usr/share/apache2/default-site/htdocs/index.html
<html>
<body>My Test Site - ha1</body>
</html>
END
    [ -f /etc/init.d/apache2 ] && service apache2 start || \
        systemctl start apache2
    # sleep to wait the service to be stable
    sleep 5
    
    # check the service
    ps aux | grep httpd || cuterr "Failed to start web service"
    
    crm configure primitive WebSite ocf:heartbeat:apache \
        params configfile=/etc/apache2/httpd.conf op monitor interval=20s
    crm configure colocation website-with-ip INFINITY: WebSite ClusterIP
    
    # configure web service on the client
    # update index.html
    ssh root@$CLIENT_IP -- cp /usr/share/apache2/default-site/htdocs/index.html \
        /usr/share/apache2/default-site/htdocs/index.html.bak
cat <<-END >${TMP_DIR}/index.html
<html>
<body>My Test Site - ha2</body>
</html>
END
    scp ${TMP_DIR}/index.html root@$CLIENT_IP:/usr/share/apache2/default-site/htdocs/
    ssh root@$CLIENT_IP -- "[ -f /etc/init.d/apache2 ] && service apache2 start || \
        systemctl start apache2; sleep 5"
    
    # check the service
    # check the service
    ssh root@$CLIENT_IP -- ps aux | grep httpd || cuterr "Failed to start web service on client"
    
    sleep 30
    curl http://$CLUSTER_IP/index.html | grep "ha1"
    if [ $? -eq 0 ]; then
        [ -f /etc/init.d/corosync ] && service corosync stop || systemctl stop corosync
        [ -f /etc/init.d/pacemaker ] && service pacemaker stop || systemctl stop pacemaker
        sleep 30
        curl http://$CLUSTER_IP/index.html | grep "ha2" && cutpass || cutfail
    elif [ "`curl http://${CLUSTER_IP} | grep -c "ha2"`" -eq 1 ]; then
        ssh root@$CLIENT_IP -- "[ -f /etc/init.d/corosync ] && service corosync stop || systemctl stop corosync"
        ssh root@$CLIENT_IP -- "[ -f /etc/init.d/pacemaker ] && service pacemaker stop || systemctl stop pacemaker"
        sleep 30
        curl http://$CLUSTER_IP/index.html | grep "ha1" && cutpass || cutfail
    else
        cutfail
    fi
}

# when control+c, need to clean the system if needed
trap "clean"  2

# fencing a node
issue_fencing()
{
    crm configure property stonith-enabled=false
    crm configure show | grep st-ssh
    if [ $? -eq 0 ]; then
        crm resource stop st-ssh
        sleep 30
        crm configure delete st-ssh
    fi
    
    # check the stonith devices, especially ssh
    stonith -L | grep ssh || cutna "Not found ssh stonith device"
    
    # configure the stonith resource
    crm configure primitive st-ssh stonith:ssh params hostlist="$HOSTNAME1 $HOSTNAME2"
    crm configure clone fencing st-ssh
    crm configure show
    
    # enable stonith attribute
expect <<- END
spawn crm configure property stonith-enabled=true
expect {
        "Do you still want to commit (y/n)?"    {send  "y\r"}
        "*"    {send  "\r"}
    }
send "exit\r"
expect eof
END
[ $? -eq 0 ] || cuterr "failed to enable stonith attribute"
    
    crm configure show 
    # issue stonith opetation
expect <<- END
spawn crm node fence $HOSTNAME2
expect {
        "Fencing $HOSTNAME2 will shut down the node"    {send  "y\r"}
    }
send "exit\r"
expect eof
END
[ $? -eq 0 ] || cuterr "failed to shoot $HOSTNAME2"
    sleep 20
    crm_mon -1 | grep -i 'online' | grep -q $HOSTNAME2 && cutfail || cutpass
}

monitor_web()
{
    # disable stonith as we don't configure stonith device here
    crm configure property stonith-enabled=false
    crm configure property no-quorum-policy=ignore

    # clean the web service setting
    clean_apache

    which systemctl
    if [ $? -eq 0 ]; then 
        systemctl start apache2 || cuterr "Failed to start web service"
    else
        service apache2 start || cuterr "Failed to start web service"
    fi

    # configure WebSite resource and monitor parameter
    crm configure primitive WebSite ocf:heartbeat:apache params configfile=/etc/apache2/httpd.conf op monitor interval=60s timeout=60s enabled=true 

    # configure another monitor parameter
    crm configure monitor WebSite 80s:80s

    # sleep to wait the cib update
    sleep 30

    # check the two monitor configurations
    mon_num=`crm configure show | grep -c monitor`
    if [ "$mon_num" -ne 2 ]; then
        cutfail
    fi

    # stop the web service
    which systemctl
    if [ $? -eq 0 ]; then 
        systemctl stop apache2 || cuterr "Failed to stop web service"
    else
        service apache2 stop || cuterr "Failed to stop web service"
    fi

    # sleep at least one monitor period
    sleep 60

    # check the monitor event
    crm status show | grep WebSite_monitor | grep "not running" && \
        cutpass || cutfail
}

main_fun()
{
    case $1 in
    "fencing")
        setup_cluster
        issue_fencing
        ;;
    "ip")
        # setup cluster
        setup_cluster
        start_web
        ;;
    "mac")
        # setup cluster
        setup_cluster
        start_web
        ;;
    "mon")
        setup_cluster
        monitor_web
        ;;
    *)
      exit 1
      ;;
    esac
}
