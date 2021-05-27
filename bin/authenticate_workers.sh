#!/usr/bin/env bash

echo KUBECONFIG = $KUBECONFIG

# substitute nodegroup arn into ../kube/aws-auth-cm.yaml
# arn is produced by cloudformation process, arn looks like this
# arn:aws:iam::************:role/eks-worker-nodes1-1-NodeInstanceRole-XGUWNN6Y2E3

STACKNAME="eks-worker-nodes1-1"

ARN=$(aws cloudformation describe-stacks \
    | jq -r --arg STACKNAME "$STACKNAME" \
    '.Stacks[] | select(.StackName==$STACKNAME).Outputs[] | select(.OutputKey=="NodeInstanceRole").OutputValue')

ARN=arn:aws:cloudformation:eu-west-2:005459661421:stack/eks-worker-nodes1-1/2bc80ff0-bee2-11eb-9f4e-0a186d27a17c
echo ARN : $ARN

cat <<EOF > ../kube/aws-auth-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${ARN}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
EOF

kubectl apply -f ../kube/aws-auth-cm.yaml