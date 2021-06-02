
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
TAGS="role=$NAME"
POLICY_ARN=arn:aws:iam::$ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy
EXTRA_POLICY_ARN=arn:aws:iam::$ACCOUNT_ID:policy/AWSLoadBalancerControllerAdditionalIAMPolicy


aws cloudformation delete-stack --stack-name eksctl-$NAME-addon-iamserviceaccount-kube-system-aws-load-balancer-controller
sleep 10
aws iam delete-policy --policy-arn $POLICY_ARN
sleep 10
aws iam delete-policy --policy-arn $EXTRA_POLICY_ARN

rm -rf iam_policy.json
rm -rf iam_policy_v1_to_v2_additional.json

curl -s -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/install/iam_policy.json

POLICY_ARN=$(aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json | jq -r .Policy.Arn)

echo POLICY_ARN = $POLICY_ARN  

eksctl create iamserviceaccount \
  --cluster=$NAME \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=$POLICY_ARN \
  --override-existing-serviceaccounts \
  --approve 

ROLEID=$(aws cloudformation list-stack-resources \
    --stack-name eksctl-$NAME-addon-iamserviceaccount-kube-system-aws-load-balancer-controller\
     | jq -r '.StackResourceSummaries[0].PhysicalResourceId')


echo ROLEID = $ROLEID

curl -o iam_policy_v1_to_v2_additional.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/install/iam_policy_v1_to_v2_additional.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerAdditionalIAMPolicy \
  --policy-document file://iam_policy_v1_to_v2_additional.json

aws iam attach-role-policy \
  --role-name $ROLEID \
  --policy-arn $EXTRA_POLICY_ARN