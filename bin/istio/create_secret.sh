#!/bin/bash

KEY=/Users/justin/acme/certs/openshiftlabs.net/openshiftlabs.net.key
CERT=/Users/justin/acme/certs/openshiftlabs.net/openshiftlabs.net.cer

kubectl delete -n kong secret kong-tls-credentials 

kubectl create -n kong secret tls kong-tls-credentials --key=${KEY} --cert=${CERT}

