#!/bin/bash

# Validating the user who runs the script is root user or not
# In linux , root user's gid or uid is always 0

USER_ID=$(id -u)

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
echo "Configuring Frontend"
echo -n "Installing Frontend:"         # -n will make sure the next output line stays in the same line

yum install nginx -y   &>>  /tmp/Frontend.log
Status $?

echo -n "Starting Nginx:"
systemctl enable nginx  &>>  /tmp/Frontend.log
systemctl enable nginx  &>>  /tmp/Frontend.log
Status $?

echo -n "Downloading the Frontend Component:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
Status $?

echo -n "Cleanp Frontend:" 
cd /usr/share/nginx/html    &>>  /tmp/Frontend.log
rm -rf *                    &>>  /tmp/Frontend.log
Status $?

echo -n "Extracting Frontend:"
unzip /tmp/frontend.zip     &>>  /tmp/Frontend.log
Status $?

echo -n "Sortind the Frontend files:"
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
Status $?

echo -n "Restarting Frontend:"
systemctl daemon-reload      &>>  /tmp/Frontend.log
systemctl restart ngins      &>>  /tmp/Frontend.log
