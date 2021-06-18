#!/bin/bash

# https://istio.io/latest/docs/setup/install/helm/

unset KUBECONFIG

COMMAND=kubectl

$COMMAND create namespace istio-system

helm install istio-base jd_repos/base -n istio-system

helm install istio-discovery jd_repos/istio-discovery \
    -n istio-system

helm install istio-ingress jd_repos/istio-ingress \
    -n istio-system

helm install istio-egress jd_repos/istio-egress \
    -n istio-system

kubectl apply -f istio-1.10.0/samples/addons/prometheus.yaml

kubectl apply -f istio-1.10.0/samples/addons/grafana.yaml

kubectl apply -f istio-1.10.0/samples/addons/jaeger.yaml

kubectl apply -f istio-1.10.0/samples/addons/kiali.yaml            