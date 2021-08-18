#!/bin/bash

USER=default

TOKEN=$(kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/$USER -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}")

echo $TOKEN | pbcopy

echo $TOKEN
