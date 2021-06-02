#!/bin/bash

NS=e2e

kubectl create namespace kong-$NS

helm install -n kong-$NS $NS kong/kong --set ingressController.installCRDs=false