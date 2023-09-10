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

echo -n "Installing ${Component}: "
yum install -y mongodb-org      &>> ${Logfile}
Status $?

# Make sure to change the ip address from 127.0.0.1 to 0.0.0.0 
# using sed -ie 's/127.0.0.1/0.0.0.1/g' mongod.conf

echo -n "Enabling the ${Component} visibility: "
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
Status $?

echo -n "Starting the ${Component}: "
systemctl enable mongod      &>> ${Logfile}
systemctl restart mongod     &>> ${Logfile}
Status $?

echo -n "Downloading the ${Component} schema: "
curl -s -L -o /tmp/${Component}.zip "https://github.com/stans-robot-project/${Component}/archive/main.zip"
Status $?

echo -n "Extracting the ${Component} schema: "
cd /tmp
unzip -o ${Component}.zip      &>> ${Logfile}
Status $?

echo -n "Injecting the ${Component} schema: "
cd ${Component}-main     
mongo < catalogue.js     &>> ${Logfile}
mongo < users.js         &>> ${Logfile}
Status $?

echo -e "\e[35m Configuring ${Component} Complete.....! \e[0m"
