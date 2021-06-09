#!/bin/bash

export KUBECONFIG=~/aws/kubeconfig-justin && eksctl utils write-kubeconfig dev1
cat $KUBECONFIG | yq e '.users.[].user.exec.env += ["name: AWS_PROFILE", "value: justin"]' - -- | sed 's/ansible./justin./g' | sponge $KUBECONFIG

echo KUBECONFIG = $KUBECONFIG

kubectl get pods