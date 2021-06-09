#!/bin/bash

mkdir -p ~/.aws

cat << EoF > ~/.aws/config
[profile justin]
role_arn=arn:aws:iam::${AWS_ACCOUNT}:role/k8sAdmin
source_profile=justin

[profile richard]
role_arn=arn:aws:iam::${AWS_ACCOUNT}:role/k8sAdmin
source_profile=richard

[profile mike]
role_arn=arn:aws:iam::${AWS_ACCOUNT}:role/k8sAdmin
source_profile=mike

EoF

cat << EoF > ~/.aws/credentials

[justin]
aws_access_key_id=$(jq -r .AccessKey.AccessKeyId ~/aws/justindav1s.json)
aws_secret_access_key=$(jq -r .AccessKey.SecretAccessKey ~/aws/justindav1s.json)

[richard]
aws_access_key_id=$(jq -r .AccessKey.AccessKeyId ~/aws/richard.walker.json)
aws_secret_access_key=$(jq -r .AccessKey.SecretAccessKey ~/aws/richard.walker.json)

[mike]
aws_access_key_id=$(jq -r .AccessKey.AccessKeyId ~/aws/mike.croft.json)
aws_secret_access_key=$(jq -r .AccessKey.SecretAccessKey ~/aws/mike.croft.json)

EoF

aws sts get-caller-identity --profile justin
aws sts get-caller-identity --profile richard
aws sts get-caller-identity --profile mike