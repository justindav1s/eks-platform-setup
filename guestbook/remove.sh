#!/usr/bin/env bash

echo KUBECONFIG = $KUBECONFIG

NS=guestbook

kubectl delete \
    rc/redis-master \
    rc/redis-slave \
    rc/guestbook \
    svc/redis-master \
    svc/redis-slave svc/guestbook \
    -n $NS