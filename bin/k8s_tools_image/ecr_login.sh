#!/bin/bash


export DOCKER_PASSWORD=$(aws ecr get-login-password --region ${AWS_REGION})

echo $DOCKER_PASSWORD

docker login -u AWS -p $DOCKER_PASSWORD https://${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com