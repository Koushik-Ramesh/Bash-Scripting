#!/bin/bash

USER_ID=$(id -u)
Component=mysql
Logfile="/tmp/${Component}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script must be executed as root user or sudo prefix \e[0m"
    exit 1
fi

Status(){
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
    fi

}

echo -e -n "Configuring the ${Component} repo: "
curl -s -L -o /etc/yum.repos.d/${Component}.repo https://raw.githubusercontent.com/stans-robot-project/${Component}/main/${Component}.repo
Status $?

echo -e -n "Installing ${Component}: "
yum install mysql-community-server -y       &>> ${Logfile}
Status $?

echo -n "Starting ${Component}:"
systemctl enable mysqld  &>>  ${Logfile}
systemctl enable mysqld &>>  ${Logfile}
Status $?

