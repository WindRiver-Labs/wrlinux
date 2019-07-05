#!/bin/sh
# Copyright (c) 2008 Wind River Systems, Inc.
# description :
# developer : Chi Xu <chi.xu@windriver.com>
#
# changelog 
# * 
# -

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/env/runtime_env

result()
{
   echo "Test Result : [ $1 ]"
	clean
}

check()
{
RET=$?
if [ $RET -ne 0 ]
then
        error "$1" $2
fi
}

#checkerr: if the program failed the 
#test is not pass and echo the $1 as
#the err message
checkerr()
{
  if [ ! $? = 0 ]
  then 
   cuterr "$1"
  fi
}



error()
{
echo "Error step : $1"
if [ "$2" == "1" ]
then
	result NOTRUN
	exit 1
else
	result FAILED
#	if [ "$RET" != "" ] && [ $RET -ne 0 ]
#	then
#		exit $RET
#	fi
	exit 2
fi
}

#add genaral reprot function
cutpass()
{
   result "PASSED"
   exit 0
}
cutna()
{
  error "N/A reason:$1" 1  #1 for not run, and means N/A
}

cuterr()
{
  error "test failed:$1" 2  #2 for failed
}
cutfail()
{
   error "test failed" 2  #2 for failed
}


getkernelbit()
{
  if [ -e /proc/config.gz ]
  then
     config=$(zcat /proc/config.gz | grep "CONFIG_64BIT=y")
     if [ "$config" = "CONFIG_64BIT=y" ]
     then          
          echo "64"
     else 
          echo "32"
     fi
  else  #cannot access proc/config.gz
     echo "Cannot access proc/config.gz"
  fi
}
#########################################
getip()
{
IPADDR=`ifconfig | grep -A 1 $1 | grep inet | awk '{print $2}' | cut -d: -f 2`
}

getmac()
{
MACADDR=`ifconfig | grep $1 | awk '{print $5}'`
}

getmask()
{
MASK=`ifconfig | grep -A 1 $1 | grep Mask | awk -F: '{print $NF}'`
}

getgateway()
{
GATEWAY=`route | tail -n 1 | awk '{print $2}'`
}

getbcast()
{
BCAST=`ifconfig | grep -A 1 $1 | grep Bcast | awk -F" " '{print $3}' | awk -F: '{print $2}'`
}


#return a ip list of host in same subnet
localhostv4()
{
   ping 224.0.0.1 -c 2 -s 56 | grep "64 bytes from" | awk  '{ print $4 }' | awk -F ':'  '{print  $1 }'

}

#return a ip list of host in same subnet
localhostv6()
{
   host=$(ping6 ff02::1 -c 2 -I $1 -s 56 | grep "64 bytes from" | awk '{print $4}')
   #$host is a list like fe80::21a:a0ff:febb:2b9b:
   # then remove the last :
   for h in $host
   do
      echo ${h%:}
   done
}

#get a name list of eth# which is up
getethup()
{
  ifconfig | grep eth | awk '{print $1}'
}
#*******************************************************
#Need two variables. $1 is user name, $2 is new password
#*******************************************************
changepasswd()
{
expect <<- END
spawn passwd $1

expect {
	eof  {exit 1}
	"New UNIX password: "		{send "$2\r"}
	"Enter new password: "		{send "$2\r"}
	"*unkonwn user*"	{exit 1}
	}

expect	{
	eof  {exit 4}
	"Retype new UNIX password: "	{send "$2\r"}
	"Enter new password: "		{send "$2\r"}
	}

expect	{
	eof  {exit 0}
	"Enter new password: " 		{send "$2\r"}
	}

expect eof
exit

END
}


#*****************************************************
#Need three variables. 
# $1 is the path of configure file
# $2 is the option whitch need be changeed
# $3 is the new value of option
#*****************************************************
choption()
{
OPTION=`sed -n -e '/^'"$2"'=/p' $1 | cut -d= -f 2`
echo "1 : $OPTION"
if [ "$OPTION" = "" ]
then
	OPTION=`sed -n -e '/^#'"$2"'=/p' $1 | cut -d= -f 2`
	echo "2 : $OPTION"
	if [ "$OPTION" = "" ]
	then
		OPTION=`sed -n -e '/^# '"$2"'=/p' $1 | cut -d= -f 2`
		echo "3 : $OPTION"
		if [ "$OPTION" = "" ]
		then 
			OPTION=`sed -n -e '/^'"$2"' =/p' $1 | cut -d= -f 2`
			if [ "$OPTION" = "" ]
			then
				OPTION=`sed -n -e '/^#'"$2"' =/p' $1 | cut -d= -f 2`
				if [ "$OPTION" = "" ]
				then 
					OPTION=`sed -n -e '/^# '"$2"' =/p' $1 | cut -d= -f 2`
					if [ "$OPTION" = "" ]
					then
						echo $2
						echo $3
						echo "$2=$3" >> $1
						return
					else
						sed -i '/^# '"$2"' =/s/^# //g' $1
						sed -i '/'"$2"' =/s/'"$OPTION"'/'"$3"'/g' $1
						return
					fi
				else
					sed -i '/^#'"$2"' =/s/^# //g' $1
					sed -i '/'"$2"' =/s/'"$OPTION"'/'"$3"'/g' $1
                                        return
				fi
			else
				sed -i '/'"$2"' =/s/'"$OPTION"'/'"$3"'/g' $1
				return
			fi
		else
			sed -i '/^# '"$2"'=/s/^# //g' $1
			sed -i '/'"$2"'=/s/'"$OPTION"'/'"$3"'/g' $1
			return
		fi
	else
		sed -i '/^#'"$2"'=/s/^# //g' $1
		sed -i '/'"$2"'=/s/'"$OPTION"'/'"$3"'/g' $1
		return
	fi
else
	sed -i '/'"$2"'=/s/'"$OPTION"'/'"$3"'/g' $1
	return
fi

}

# setup auto-login ssh from target to client
# need one ip variable to specify which client used
# to set up autossh
autossh()
{
    rm -rf /root/.ssh
expect <<- END
spawn ssh-keygen -t rsa
expect {
        "Enter file in which to save the key (/root/.ssh/id_rsa):"  {send "\r"}
     }

expect {
        "Enter passphrase"    {send  "\r"}
    }
expect {
        "Enter same passphrase"    {send  "\r"}
    }
send "exit\r"
expect eof
END
[ $? -eq 0 ] || cuterr "failed to set up autologin ssh"
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys || cutfail
expect <<- END
spawn ssh -o "StrictHostKeyChecking no" root@$1 -- mkdir -p /root/.ssh
expect {
        "root@$1's password:"    {send  "root\r"}
    }
sleep 1
exit
expect eof
END
[ $? -eq 0 ] || cuterr "failed to set up autologin ssh"
expect <<- END
spawn scp -o "StrictHostKeyChecking no" /root/.ssh/id_rsa.pub root@$1:/root/.ssh/authorized_keys
expect {
        "root@$1's password:"    {send  "root\r"}
    }
sleep 1
exit
expect eof
END
[ $? -eq 0 ] || cuterr "failed to set up autologin ssh"
expect <<- END
spawn ssh root@$1 -- uname
expect {
        "root@$1's password:"    {exit 1}
    }
sleep 1
exit
expect eof
END
[ $? -eq 0 ] || cuterr "failed to set up autologin ssh"
}

check_localeth()
{
    # Hint: you may need to configure LOCAL_ETH under
    # /opt/cut/env/runtime_env
    if [ x"$LOCAL_ETH" = x ]; then
        echo "Error: Empty local interface."
        echo " Note: This test case requires two targets,"
        echo "please set LOCAL_ETH which used to connect "
        echo "other target in /opt/cut/env/runtime_env"
        echo "before running the test script, or it will always fail."
        cutfail
    fi
}

get_targetip()
{
    check_localeth
    target_ip="`ifconfig $LOCAL_ETH | grep 'inet ' | sed 's/^.*inet addr://g' | \
    sed 's/ *Mask.*$//g'|sed 's/ *Bcast.*$//g'`"
    if [ -z $target_ip ]; then
        cuterr "Invalid target ip"
    fi
    echo $target_ip
}

# customize the /etc/hosts
# need four variables
# $1 specify local target hostname
# $2 specify local target ip
# $3 specify client hostname
# $4 specify client target ip
cus_hosts()
{
    if [ $# -ne 4 ]; then
        echo "The parameter should be four as: "
        echo "cus_hosts hostname1 ip1 hostname2 ip2"
        cutfail
    fi
    # backup /etc/hosts
    cp /etc/hosts /etc/hosts.bak
    ssh root@$4 -- cp /etc/hosts /etc/hosts.bak
    # customize the /etc/hosts on local target
    echo "$2 $1" >> /etc/hosts
    echo "$4 $3" >> /etc/hosts

    # customize the /etc/hosts on client target
    scp /etc/hosts root@$4:/etc/ || cuterr "Failed to customize the /etc/hosts on client target"
}

# need one parameter
# $1 specify the ip used to check
# check rules:
# 1. the ip mustn't be null
# 2. the ip should be 4 decimals sperated by dot
#    and each item must be less than 255 and greater
#    than 0
valid_ip()
{
    if [ x"$1" = x ]; then
        return 1
    fi
    n_ip=`echo $1 | awk -F . '{print NF}'`
    if [ $n_ip -ne 4 ]; then
        return 2
    fi

    if expr "$1" : '^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$'; then
        :
    else
        return 2
    fi
    ip1=`echo $1 | awk -F . '{print $1}'`
    ip2=`echo $1 | awk -F . '{print $2}'`
    ip3=`echo $1 | awk -F . '{print $3}'`
    ip4=`echo $1 | awk -F . '{print $4}'`
    for testip in $ip1 $ip2 $ip3 $ip4
    do
        if [ $testip -ge 255 ] || [ $testip -lt 1 ]; then
            return 2
        fi
    done
    return 0
}

# need two parameters
# $1 specify the ip address
# $2 specify the netmask
get_netaddr()
{
    ip4="${1##*.}" ; x="${1%.*}"
    ip3="${x##*.}" ; x="${x%.*}"
    ip2="${x##*.}" ; x="${x%.*}"
    ip1="${x##*.}"

    nm4="${2##*.}" ; x="${2%.*}"
    nm3="${x##*.}" ; x="${x%.*}"
    nm2="${x##*.}" ; x="${x%.*}"
    nm1="${x##*.}"

    sn1=$(($ip1&$nm1))
    sn2=$(($ip2&$nm2))
    sn3=$(($ip3&$nm3))
    sn4=$(($ip1&$nm4))
    netaddr=$sn1.$sn2.$sn3.$sn4
    echo $netaddr
}

# check CLIENT_IP validity
# each true when the client ip is valid
valid_clientip()
{
    # Hint: you may need to configure CLIENT_IP under
    # /opt/cut/env/runtime_env
    valid_ip $CLIENT_IP
    ret_val=$?
    if [ $ret_val -eq 1 ]; then
        echo "Error: Empty client ip."
        echo "Note: This test case requires two targets,"
        echo "please prepare another target as client and set"
        echo "CLIENT_IP in /opt/cut/env/runtime_env"
        echo "before running the test script, or it will always fail."
        cutfail
    elif [ $ret_val -eq 2 ]; then
        cuterr "Invalid client ip"
    fi
    
    # check basic connectivity
    ping -c 3 $CLIENT_IP || cuterr "client ip unreachable"
}
