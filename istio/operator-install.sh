#!/bin/bash


#kubectl create namespace istio-operator


helm install istio-operator jd_repos/istio-operator \
  --set operatorNamespace=istio-operator \
  --set watchedNamespaces="istio-system"

kubectl create namespace istio-system

sleep 15

kubectl -n istio-system apply -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: istiocontrolplane
spec:
  profile: demo
  values:
    global:
      logging:
        level: debug 
  meshConfig:
    outboundTrafficPolicy.mode: REGISTRY_ONLY
    accessLogFile: /dev/stdout        
EOF

kubectl -n istio-system apply -f istio-1.10.0/samples/addons/prometheus.yaml

kubectl -n istio-system apply -f istio-1.10.0/samples/addons/grafana.yaml

kubectl -n istio-system apply -f istio-1.10.0/samples/addons/jaeger.yaml

kubectl -n istio-system apply -f istio-1.10.0/samples/addons/kiali.yaml