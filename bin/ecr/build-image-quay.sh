#!/usr/bin/env bash

IMAGE=k8s-tools
VERSION=1.3
REGISTRY_HOST=quay.io/justindav1s

docker build -t $IMAGE .

TAG=$REGISTRY_HOST/$IMAGE:$VERSION

docker tag $IMAGE $TAG

docker login -p $QUAYIO_PASSWORD -u $QUAYIO_USER $REGISTRY_HOST

docker push $TAG
