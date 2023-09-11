#!/bin/bash

USER_ID=$(id -u)
Component=redis
Logfile="/tmp/${Component}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script must be executed as root user or sudo prefix \e[0m"
    exit 1
fi

Status(){
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[33m Failure \e[0m"
    fi

}

echo "Configuring ${Component}"

echo -n "Configuring ${Component} repo:"    
curl -L https://raw.githubusercontent.com/stans-robot-project/${Component}/main/${Component}.repo -o /etc/yum.repos.d/${Component}.repo    &>> ${Logfile} 
Status $?

echo -n "Installing ${Component}: "
yum install redis-6.2.12 -y      &>> ${Logfile}
Status $?

# Make sure to change the ip address from 127.0.0.1 to 0.0.0.0 
# using sed -ie 's/127.0.0.1/0.0.0.1/g' mongod.conf

echo -n "Enabling the ${Component} visibility: "
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/${Component}.conf
Status $?

echo -n "Starting the ${Component}: "
systemctl daemon-reload     &>> ${Logfile}
systemctl enable ${Component}      &>> ${Logfile}
systemctl restart ${Component}     &>> ${Logfile}
Status $?

echo -e "\e[35m Configuring ${Component} Complete.....! \e[0m"