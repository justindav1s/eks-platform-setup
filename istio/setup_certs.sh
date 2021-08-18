#!/bin/bash

APP=kong
DOMAIN=kubernetes.docker.internal

rm -rf *${DOMAIN}*

kubectl delete -n default secret tls-keys 
kubectl delete -n istio-system secret tls-keys
kubectl delete -n kong secret tls-keys

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=Kong Inc./CN=${DOMAIN}' -keyout ${DOMAIN}.key -out ${DOMAIN}.crt

openssl req -out ${APP}.${DOMAIN}.csr -newkey rsa:2048 -nodes -keyout ${APP}.${DOMAIN}.key -subj "/CN=${APP}.${DOMAIN}/O=${APP} organization"
openssl x509 -req -days 365 -CA ${DOMAIN}.crt -CAkey ${DOMAIN}.key -set_serial 0 -in ${APP}.${DOMAIN}.csr -out ${APP}.${DOMAIN}.crt

sleep 5

# kubectl create -n default secret tls tls-keys --key=${APP}.${DOMAIN}.key --cert=${APP}.${DOMAIN}.crt
# kubectl create -n istio-system secret tls tls-keys --key=${APP}.${DOMAIN}.key --cert=${APP}.${DOMAIN}.crt
# kubectl create -n kong secret tls tls-keys --key=${APP}.${DOMAIN}.key --cert=${APP}.${DOMAIN}.crt

kubectl create -n istio-system secret tls tls-keys --key=${APP}.${DOMAIN}.key --cert=${APP}.${DOMAIN}.crt -o yaml > tls-keys.yaml

# And for sops

# sops --encrypt --in-place tls-keys.yaml
