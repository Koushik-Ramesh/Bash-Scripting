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
AMI_ID="ami-0c1d144c8fdd8d690"
INSTANCE_TYPE="t2.micro"-
SG_ID="sg-0ca0742615a57b999"     #Security group id - koushik allow all

aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SG_ID} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${Component}}]' ]

# Each and every resource created will have tags

