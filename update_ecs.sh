#!/bin/bash

# Some environment variables required
# HUBOT_SLACK_TOKEN
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_REGION

REPLACED_FILE=replaced_ecs_task_definition.json
MYSECURITYGROUP=sg-34fc6d51
#MYIP=`curl -s inet-ip.info`
MYIP=`curl -s ifconfig.me`
echo "MYIP is $MYIP"

# Replace variables
bash ./replace_variables.sh ecs_task_definition.json $REPLACED_FILE
sed -i -e "s/\${CIRCLE_BUILD_NUM}/$1/g" $REPLACED_FILE

# Set aws config
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_REGION

aws ec2 authorize-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32

result=`aws ecs register-task-definition --family myhubot --container-definitions file://./$REPLACED_FILE` >/dev/null 2>&1
echo $result
revision=`echo $result | jq '.["taskDefinition"]["revision"]'`
aws ecs update-service --cluster hubot --service hubot --task-definition myhubot:$revision --desired-count 1

aws ec2 revoke-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32

# Remove needless file
rm -rf $REPLACED_FILE
