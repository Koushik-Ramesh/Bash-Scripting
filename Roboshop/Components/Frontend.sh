#!/bin/bash

# Validating the user who runs the script is root user or not
# In linux , root user's gid or uid is always 0

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script must be executed as root user or sudo prefix \e[0m"
    exit 1
fi

echo "Configuring Frontend"

yum install nginx -y