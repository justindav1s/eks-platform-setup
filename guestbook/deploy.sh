#!/usr/bin/env bash

echo KUBECONFIG = $KUBECONFIG

NS=guestbook

kubectl delete namespace $NS

kubectl create namespace $NS

kubectl apply -f redis-master-deployment.yaml -n $NS

kubectl apply -f redis-master-service.yaml -n $NS

kubectl apply -f redis-slave-deployment.yaml -n $NS

kubectl apply -f redis-slave-service.yaml -n $NS

kubectl apply -f frontend-deployment.yaml -n $NS

kubectl apply -f frontend-service.yaml -n $NS

kubectl get services -o wide -n $NS