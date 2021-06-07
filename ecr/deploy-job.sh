#!/usr/bin/env bash

export KUBECONFIG=/Users/justin/.kube/eksdev1.config
export AWS_ACCOUNT=$(cat ~/aws/account.txt) 
export AWS_KEY_ID=$(cat ~/aws/ecr_credentials.csv | tail -1 | cut -d "," -f 3)
export AWS_KEY=$(cat ~/aws/ecr_credentials.csv | tail -1 | cut -d "," -f 4)
export AWS_DEFAULT_REGION="eu-west-2"

SA_USER=ecr-creds-agent

kubectl -n default delete sa ${SA_USER}
kubectl -n default delete Cronjob aws-registry-credential-cron
kubectl -n default delete secret aws-ecr-secrets

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: aws-ecr-secrets
  namespace: default
data:
stringData:
  credentials: |-
    [default]
    aws_access_key_id=${AWS_KEY_ID}
    aws_secret_access_key=${AWS_KEY}
  config: |-
    [default]
    region=${AWS_DEFAULT_REGION}
  account: |-
    ${AWS_ACCOUNT}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: $SA_USER
  namespace: default
EOF

cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $SA_USER
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: $SA_USER
  namespace: default
EOF

kubectl -n default apply -f aws.cron.yml