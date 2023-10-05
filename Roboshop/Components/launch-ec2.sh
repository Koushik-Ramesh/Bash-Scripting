#!/bin/bash

<<COMMENT
To create a server, information needed are:
1. AMI ID
2. TYPE OF INSTANCE
3. SECURITY GROUP
4. INSTANCES YOU NEED
5: DNS RECORD: HOSTED ZONE ID
COMMENT

Component=$1
ENV=$2
HOSTEDZONEID="Z07818693FQRAM16MSR86"
INSTANCE_TYPE="t2.micro"

if [ -z $1 ] || [ -z $2 ] ; then
    echo -e "\e[31m Component name is required \e[0m \n\t\t"
    echo -e "\e[36m Ex usage $ bash Components/launch-ec2 \e[0m"
    exit 1
fi

# AMI_ID="ami-0c1d144c8fdd8d690"

AMI_ID="$(aws ec2 describe-images --filters "Name=name, Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')"

# SG_ID="sg-0ca0742615a57b999"     #Security group id - koushik allow all
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=Koushik_allow_all | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')"

create_ec2() {
    echo -e "*************Creating \e[34m ${Component}\e[0m Server is in Progress*********** "
    PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${Component}-${ENV}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    echo -e "Private IP address of the ${Component-${ENV}} is $PRIVATEIP \n"
    echo -e "Creating DNS Record of ${Component} :"

    sed -e "s/Component/${Component}-${ENV}/"  -e "s/IPADDRESS/${PRIVATEIP}/" route53.json > /tmp/r53.json
    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/r53.json
    echo -e "\e[33m ********Creating DNS Record for the $Component has been completed ******\e[0m"
}

if [ "$1" == "all" ]; then

    for component in mongodb catalogue cart user shipping frontend payment msql redis rabbitmq; do
        Component=$component
        create_ec2
    done
else
        create_ec2
fi

# Each and every resource created will have tag in it 
# Any information presented in [] is called list