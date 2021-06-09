#!/bin/bash

export KUBECONFIG=~/.kube/eksdev1.config

export TOKEN=$(kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}")
export SERVER=https://EFA94DF9F7D2E0E18D12ED4DF843AF82.gr7.eu-west-2.eks.amazonaws.com

kubectl get kustomization flux-system -n flux-system -o json > kustomization.json

curl -k -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -X PUT \
    --data-binary @kustomization.json \
    $SERVER/apis/kustomize.toolkit.fluxcd.io/v1beta1/namespaces/flux-system/kustomizations/flux-system

kubectl get namespace flux-system -o json > flux-system-ns.json  

echo sleeping .....
sleep 60

curl -k -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -X PUT \
    --data-binary @flux-system-ns.json  \
    $SERVER/api/v1/namespaces/flux-system/finalize