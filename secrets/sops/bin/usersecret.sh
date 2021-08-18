#!/bin/bash


kubectl -n shop-app-dev create secret generic dev-db-secret \
  --dry-run='client' \
  --from-literal=username=devuser \
  --from-literal=password='ScottTiger' -o yaml > dev-db-secret.yaml