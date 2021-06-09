#!/bin/bash

KEY=/Users/justin/acme/certs/openshiftlabs.net/openshiftlabs.net.key
CERT=/Users/justin/acme/certs/openshiftlabs.net/openshiftlabs.net.cer

kubectl delete -n istio-system secret kong-tls-credentials 

kubectl create -n istio-system secret tls kong-tls-credentials --key=${KEY} --cert=${CERT}

