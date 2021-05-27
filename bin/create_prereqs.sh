#!/usr/bin/env bash

export AWS_ACCESS_KEY_ID=$(cat ../credentials.csv | tail -1 | cut -d "," -f 3)
export AWS_SECRET_ACCESS_KEY=$(cat ../credentials.csv | tail -1 | cut -d "," -f 4)
export AWS_DEFAULT_REGION="eu-west-2"

echo AWS_ACCESS_KEY_ID = $AWS_ACCESS_KEY_ID
echo AWS_SECRET_ACCESS_KEY = $AWS_SECRET_ACCESS_KEY
echo AWS_DEFAULT_REGION = $AWS_DEFAULT_REGION


ansible-playbook -vvvv -i ../playbooks/inventory/hosts ../playbooks/build_prereqs.yaml