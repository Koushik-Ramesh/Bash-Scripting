#!/bin/bash

USER_ID=$(id -u)
Component=catalogue
Logfile="/tmp/${Component}.log"
APPUSER="roboshop"

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
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
Status $?

echo -n "Installing Nodejs: "   
yum install nodejs -y      &>> ${Logfile}
Status $?

id ${APPUSER}       &>> ${Logfile}
if [ $? -ne 0 ] ; then
    echo -n "Creating Application user account: "
    useradd roboshop
    Status $?
fi

echo -n "Downloading the ${Component}: "
curl -s -L -o /tmp/${Component}.zip "https://github.com/stans-robot-project/${Component}/archive/main.zip"
Status $?

echo -n "Copying the ${Component} to ${APPUSER} home directory: "
cd /home/${APPUSER}/
rm -rf ${Component}     &>> ${Logfile}
unzip -o /tmp/${Component}.zip      &>> ${Logfile}
Status $?

echo -n "Changing the ownership: "
mv ${Component}-main ${Component}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${Component}/
Status $?
