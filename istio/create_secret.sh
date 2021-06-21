#!/bin/bash

KEY=/Users/justin/acme/certs/openshiftlabs.net/openshiftlabs.net.key
CERT=/Users/justin/acme/certs/openshiftlabs.net/openshiftlabs.net.cer

kubectl delete -n default secret tls-keys 
kubectl delete -n istio-system secret tls-keys

kubectl create -n default secret tls tls-keys --key=${KEY} --cert=${CERT}
kubectl create -n istio-system secret tls tls-keys --key=${KEY} --cert=${CERT}

