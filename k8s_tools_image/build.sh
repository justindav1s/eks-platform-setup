#!/usr/bin/env bash

IMAGE=k8s-tools
VERSION=latest
REGISTRY_HOST=public.ecr.aws/k8h6v2u7

docker build -t $IMAGE .

TAG=$REGISTRY_HOST/$IMAGE:$VERSION

docker tag $IMAGE $TAG

aws ecr-public get-login-password --region eu-waest-2 | docker login --username AWS --password-stdin $REGISTRY_HOST

docker push $TAG
