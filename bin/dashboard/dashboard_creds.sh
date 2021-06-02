#!/bin/bash

export KUBECONFIG=~/.kube/eksdev1.config

TOKEN=$(kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}")

echo $TOKEN | pbcopy

echo $TOKEN
