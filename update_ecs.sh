#!/bin/bash

# Some environment variables required
#HUBOT_SLACK_TOKEN
#AWS_ACCESS_KEY_ID
#AWS_SECRET_ACCESS_KEY
#AWS_REGION

REPLACED_FILE=replaced_ecs_task_definition.json
MYSECURITYGROUP=sg-34fc6d51
MYIP=`curl -s inet-ip.info`

# Replace variables
bash ./replace_variables.sh ecs_task_definition.json $REPLACED_FILE

# Set aws config
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_REGION

aws ec2 authorize-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32
aws ecs list-container-instances --cluster hubot
aws ecs register-task-definition --family myhubot --container-definitions file://./$REPLACED_FILE
aws ec2 revoke-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32

# Remove needless file
rm -rf $REPLACED_FILE
