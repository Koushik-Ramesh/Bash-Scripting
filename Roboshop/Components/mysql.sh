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

echo -n "Extracting the default mysql root password: "
DEFAULT_ROOT_PASSWORD=$(grep "temporary password"  /var/log/mysqld.log |awk -F " " '{print $NF}')
Status $?


# This should happen only once and for the first time, when it runs for second time it fails
# We need to ensure that this runs only once
echo "Show databases;" | mysql -uroot -pRoboShop@1      &>> ${Logfile}
if [ $? -ne 0 ]; then
    echo -n "Resetting the default password of root account: "
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASSWORD   &>>  ${Logfile}
    Status $?
fi

echo "show plugins;" |  mysql -uroot -pRoboShop@1 | grep validate_password  &>> ${Logfile}
if [ $? -eq 0 ]; then
    echo -n "Uninstalling plugin for password uninstallation: "
    echo "uninstall plugin validate_password" | mysql -uroot -pRoboShop@1       &>> ${Logfile}
    Status $?
fi

echo -n "Downloading the ${Component} schema: "
curl -s -L -o /tmp/${Component}.zip "https://github.com/stans-robot-project/${Component}/archive/main.zip"
Status $?

echo -n "Extracting the ${Component} schema: "
cd /tmp
unzip -o /tmp/${Component}.zip
Status $?

echo -n "Injecting the schema: "
cd ${Component}-main
mysql -u root -pRoboShop@1 <shipping.sql    &>> ${Logfile}
Status $?

echo -e "\e[35m Configuring ${Component} Complete.....! \e[0m"