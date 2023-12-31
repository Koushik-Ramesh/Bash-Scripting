# All the common functions will be declared here, rest of them will be sourcing from the file

Logfile="/tmp/${Component}.log"
APPUSER="roboshop"

USER_ID=$(id -u)

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

# Declaring NodeJS script

NodeJS(){
        echo "Configuring ${Component}"

        echo -e "Configuring ${Component} repo:"
        curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
        Status $?

        echo -n "Installing Nodejs: "   
        yum install nodejs -y      &>> ${Logfile}
        Status $?

        CREATE_USER         #Calling the function after installing the nodejs to create user account

        DOWNLOAD_AND_EXTRACT   # extracting the files

        echo -n "Generating the ${Component} artifacts: "
        cd /home/${APPUSER}/${Component}
        npm install  &>> ${Logfile}
        Status $?

        CONFIG_SERVICE

}

# Creating user account

CREATE_USER(){
    id ${APPUSER}       &>> ${Logfile}
    if [ $? -ne 0 ] ; then
        echo -n "Creating Application user account: "
        useradd roboshop
        Status $?
    fi

}

# Downloading and Extracting
DOWNLOAD_AND_EXTRACT() {

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

}

CONFIG_SERVICE(){
        echo -n "Configuring the ${Component} system file: "
        sed -ie 's/MONGO_DNSNAME/mongodb.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/REDIS_ENDPOINT/redis.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/MONGO_ENDPOINT/mongodb.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/REDIS_ENDPOINT/redis.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/CATALOGUE_ENDPOINT/catalogue.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/CARTENDPOINT/cart.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/DBHOST/mysql.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/CARTHOST/cart.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/USERHOST/user.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        sed -ie 's/AMQPHOST/rabbitmq.robosop.internal/' /home/${APPUSER}/${Component}/systemd.service
        mv /home/${APPUSER}/${Component}/systemd.service /etc/systemd/system/${Component}.service
        Status $?

        echo -n "Starting the ${Component} service: "
        systemctl daemon-reload    &>> ${Logfile}
        systemctl enable ${Component}       &>> ${Logfile}
        systemctl restart ${Component}      &>> ${Logfile}
        Status $?
}

MVN_PACKAGE() {
    echo -n "Generating the ${Component} artifacts: "
    cd /home/${APPUSER}/${Component}/
    mvn clean package   &>> {Logfile}
    mv target/${Component}-1.0.jar ${Component}.jar
    Status $?
}

JAVA() {
    echo -e "Configuring ${Component}"

    echo -n "Installing maven: "
    yum install maven -y    &>> ${Logfile}
    Status $?

    CREATE_USER         #Calling the function after installing the nodejs to create user account

    DOWNLOAD_AND_EXTRACT   # Downloading & extracting the files

    MVN_PACKAGE

    CONFIG_SERVICE
}

PYTHON() {
    echo -e "Configuring ${Component}"

    echo -n "Installing Python: "
    yum install python36 gcc python3-devel -y    &>> ${Logfile}
    Status $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    echo -n "Generating the artifacts: "  
    cd /home/${APPUSER}/${Component}/
    pip3 install -r requirements.txt    &>> {Logfile}  
    Status $?

    USERID=$(id -u roboshop)
    GROUPID=$(id -g roboshop)

    echo -n "Updating the UID and GID in the ${Component}.ini file: "
    sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c gid=${GROUPID}" /home/${APPUSER}/${Component}/${Component}.ini
    Status $? 

    CONFIG_SERVICE
}
