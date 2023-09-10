#!/bin/bash

USER_ID=$(id -u)
Component=mongodb
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
echo -e "Configuring ${Component} repo:"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
Status $?

echo -n "Installing ${Component"}:"
yum install -y mongodb-org      &>> ${Logfile}
Status $?