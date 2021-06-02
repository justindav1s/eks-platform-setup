#!/bin/bash

#setup your gitlab acess token first as shell var : GITLAB_TOKEN


CLUSTER=eks-dev1
REPO=flux2-ops
GITLAB_USER=demoplatform

kubectl create namespace flux-system

flux bootstrap gitlab \
  --owner=$GITLAB_USER \
  --repository=$REPO \
  --branch=main \
  --path=./clusters/$CLUSTER \
  --personal