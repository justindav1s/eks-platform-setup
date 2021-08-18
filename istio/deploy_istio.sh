#!/bin/bash

istioctl manifest apply \
    --set profile=default \
    --set values.global.logging.level=debug \
    --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY \
    --set meshConfig.accessLogFile=/dev/stdout \
    --set values.gateways.istio-ingressgateway.type=NodePort

kubectl apply -f istio-1.11.0/samples/addons/prometheus.yaml

kubectl apply -f istio-1.11.0/samples/addons/grafana.yaml

kubectl apply -f istio-1.11.0/samples/addons/jaeger.yaml

kubectl apply -f istio-1.11.0/samples/addons/kiali.yaml

kubectl label namespace kong istio-injection=enabled

kubectl label namespace shop-app-dev istio-injection=enable

kubectl label namespace shop-app-e2e istio-injection=enable