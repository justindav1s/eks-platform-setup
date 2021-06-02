#!/bin/bash

export KUBECONFIG=~/.kube/eksdev1.config

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml