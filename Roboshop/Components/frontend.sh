#!/bin/bash

# Validating the user who runs the script is root user or not
# In linux , root user's gid or uid is always 0

USER_ID=$(id -u)
Component=frontend
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
echo "Configuring ${Component}"
echo -n "Installing Nginx:"         # -n will make sure the next output line stays in the same line

yum install nginx -y   &>>  ${Logfile}
Status $?

echo -n "Starting Nginx:"
systemctl enable nginx  &>>  ${Logfile}
systemctl enable nginx  &>>  ${Logfile}
Status $?

echo -n "Downloading the ${Component} Component:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/${Component}/archive/main.zip"
Status $?

echo -n "Cleanp ${Component}:" 
cd /usr/share/nginx/html    
rm -rf *                    &>>  ${Logfile}
Status $?

echo -n "Extracting ${Component}:"
unzip -o /tmp/${Component}.zip     &>>  ${Logfile}
mv ${Component}-main/* .
mv static/* .
rm -rf ${Component}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
Status $?

echo -n "Updating the backend components in the reverse proxy files: "
for Component in catalogue user cart ;do
    sed -i -e "/${Component}/s/localhost/${Component}.robosop.internal/"  /etc/nginx/default.d/roboshop.conf

echo -n "Restarting ${Component}:"
systemctl daemon-reload      &>>  ${Logfile}
systemctl restart nginx      &>>  ${Logfile}
Status $?

echo -e "\e[35m Configuring ${Component} Complete.....! \e[0m"