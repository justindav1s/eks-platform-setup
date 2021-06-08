#!/bin/bash


IMAGE=inventory
OLD_VERSION=latest
NEW_VERSION=1.0.$1
REGISTRY_HOST=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com


OLD_TAG=$REGISTRY_HOST/$IMAGE:$OLD_VERSION
NEW_TAG=$REGISTRY_HOST/$IMAGE:$NEW_VERSION

export DOCKER_PASSWORD=$(aws ecr get-login-password --region ${AWS_REGION})

echo $DOCKER_PASSWORD

docker login -u AWS -p $DOCKER_PASSWORD https://${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com

docker pull $OLD_TAG

docker tag $OLD_TAG $NEW_TAG

docker push $NEW_TAG