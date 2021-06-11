#!/usr/bin/env bash

for i in $(seq 1 1000)
do
    curl -s https://heroes-dev.istio.dev1.eks.openshiftlabs.net/ > /dev/null
    curl -s https://kong-heroes-dev.istio.dev1.eks.openshiftlabs.net/actuator/prometheus  > /dev/null
    sleep 1
done







