#!/bin/bash

# Validating the user who runs the script is root user or not
# In linux , root user's gid or uid is always 0

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script must be executed as root user or sudo prefix \e[0m"
    exit 1
fi

echo "Configuring Frontend "
echo -n "Installing Frontend: "         # -n will make sure the next output line stays in the same line

yum install nginx -y   &>>  /tmp/Frontend.log
if [ $? -ep 0 ] ; then
    echo -e "\e[32m Success \e[0m"
    else 
    echo -e "\e[31m Failure \e[0m"
fi
