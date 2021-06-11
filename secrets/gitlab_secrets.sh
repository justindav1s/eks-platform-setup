#!/bin/bash

# https://fluxcd.io/docs/components/source/api/

cat <<EOF | kubectl apply -n flux-system -f -
apiVersion: v1
kind: Secret
metadata:
  name: gitlab-token
type: kubernetes.io/basic-auth
stringData:
  username: ${GITLAB_USER}
  password: ${GITLAB_TOKEN}
EOF

cat <<EOF | kubectl apply -n team2-dev -f -
apiVersion: v1
kind: Secret
metadata:
  name: gitlab-token
type: kubernetes.io/basic-auth
stringData:
  username: ${GITLAB_USER}
  password: ${GITLAB_TOKEN}
EOF

kubectl delete secret gitlabkeys -n team2-dev

kubectl create secret generic gitlabkeys \
    --from-file=identity=${HOME}/.ssh/id_rsa \
    --from-file=identity.pub=${HOME}/.ssh/id_rsa.pub \
    --from-file=known_hosts=known_hosts \
    -n team2-dev

kubectl delete secret gitlabkeys -n flux-system

kubectl create secret generic gitlabkeys \
    --from-file=identity=${HOME}/.ssh/id_rsa \
    --from-file=identity.pub=${HOME}/.ssh/id_rsa.pub \
    --from-file=known_hosts=known_hosts \
     -n flux-system