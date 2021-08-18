#!/bin/bash

kubectl create namespace kong

helm install -n kong kong kong/kong --set ingressController.installCRDs=false