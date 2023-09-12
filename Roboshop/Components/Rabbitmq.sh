#!/bin/bash

Component=rabbitmq

source Components/common.sh         # Calling the script from another script to run it

echo "Configuring ${Component}"

echo -n "Configuring the ${Component} repo: "
curl -s https://packagecloud.io/install/repositories/${Component}/erlang/script.rpm.sh | sudo bash      &>> ${Logfile}
curl -s https://packagecloud.io/install/repositories/${Component}/${Component}-server/script.rpm.sh | sudo bash     &>> ${Logfile}
Status $?

echo -n "Installing ${Component}: "
yum install rabbitmq-server -y      &>> ${Logfile}
Status $?

echo -n "Starting the ${Component}: "
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server
Status $?

echo -n "Creating ${Component} user account: "
rabbitmqctl add_user roboshop roboshop123   &>> ${Logfile}
Status $?

echo -n "Configuring the permissions: "
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
Status $?

echo -e "\e[35m Configuring ${Component} Complete.....! \e[0m"
