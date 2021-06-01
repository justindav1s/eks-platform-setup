
#!/bin/bash

export AWS_ACCESS_KEY_ID=$(cat ~/aws/ansible_credentials.csv | tail -1 | cut -d "," -f 3)
export AWS_SECRET_ACCESS_KEY=$(cat ~/aws/ansible_credentials.csv | tail -1 | cut -d "," -f 4)
export AWS_DEFAULT_REGION="eu-west-2"
export ACCOUNT_ID=$(cat ~/aws/account.txt)

echo AWS_ACCESS_KEY_ID = $AWS_ACCESS_KEY_ID
echo AWS_SECRET_ACCESS_KEY = $AWS_SECRET_ACCESS_KEY
echo AWS_DEFAULT_REGION = $AWS_DEFAULT_REGION
echo ACCOUNT_ID = $ACCOUNT_ID

NAME=dev1

helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set clusterName=$NAME \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  -n kube-system