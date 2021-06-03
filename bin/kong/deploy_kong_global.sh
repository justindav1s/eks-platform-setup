#!/bin/bash

NS=dev

kubectl create namespace kong

helm install -n kong global kong/kong --set ingressController.installCRDs=false