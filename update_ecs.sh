#!/bin/bash

MYSECURITYGROUP=sg-34fc6d51
MYIP=`curl -s inet-ip.info`

aws ec2 authorize-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_REGION

aws ecs list-container-instances --cluster hubot

aws ec2 revoke-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32
