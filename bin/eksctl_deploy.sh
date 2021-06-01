#!/bin/bash

export AWS_ACCESS_KEY_ID=$(cat ~/aws/credentials.csv | tail -1 | cut -d "," -f 3)
export AWS_SECRET_ACCESS_KEY=$(cat ~/aws/credentials.csv | tail -1 | cut -d "," -f 4)
export AWS_DEFAULT_REGION="eu-west-2"

echo AWS_ACCESS_KEY_ID = $AWS_ACCESS_KEY_ID
echo AWS_SECRET_ACCESS_KEY = $AWS_SECRET_ACCESS_KEY
echo AWS_DEFAULT_REGION = $AWS_DEFAULT_REGION

NAME=dev1
TAGS="role=$NAME"

eksctl create cluster \
--name $NAME \
--region eu-west-2 \
--version 1.19 \
--node-type t3.medium \
--nodes 1 \
--nodes-min 1 \
--nodes-max 1 \
--node-volume-size 20 \
--ssh-access \
--ssh-public-key jnd_mac_rh \
--node-ami-family AmazonLinux2 \
--managed \
--kubeconfig /Users/justin/.kube/eks$NAME.config
