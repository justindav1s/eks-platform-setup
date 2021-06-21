#!/usr/bin/env bash

PROTOCOL=https
PORT=30338

for i in $(seq 1 1000)
do
    for NS in dev e2e
    do
        #HOST=kong-shop-$NS.api.apps.ocp4.openshiftlabs.net/amazin
        HOST=shop-$NS.kubernetes.docker.internal:$PORT/amazin

        echo Iteration \# ${i}
        echo POST -H "Content-Type: application/json" -d @login_request1.json ${PROTOCOL}://${HOST}/login
        curl -sk -X POST -H "Content-Type: application/json" -d @login_request1.json ${PROTOCOL}://${HOST}/login
        echo
        cat login_request1.json | sed s/test/test${i}/ > login_request_next.json
        echo POST -H "Content-Type: application/json" -d @login_request_next.json ${PROTOCOL}://${HOST}/login
        BASKET=$(curl -sk -X POST -H "Content-Type: application/json" -d @login_request_next.json ${PROTOCOL}://${HOST}/login | jq .basketId)
        echo *****BASKET : ${BASKET}

        echo GET ${PROTOCOL}://${HOST}/products/all
        curl -sk -X GET ${PROTOCOL}://${HOST}/products/all
        echo
        echo GET ${PROTOCOL}://${HOST}/products/7
        curl -sk -X GET ${PROTOCOL}://${HOST}/products/7
        echo
        echo POST -H "Content-Type: application/json" -d @login_request2.json ${PROTOCOL}://${HOST}/user/login
        BASKET=$(curl -sk -X POST -H "Content-Type: application/json" -d @login_request2.json ${PROTOCOL}://${HOST}/login | jq .basketId)
        echo *****BASKET : ${BASKET}
        echo
        echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/1
        curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/1
        echo
        echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/7
        curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/7
        echo
        echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/1
        curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/1
        echo
        echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/9
        curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/9
        echo
        echo
        echo DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
        curl -sk -X DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
        echo
        echo GET ${PROTOCOL}://${HOST}/basket/${BASKET}/empty
        curl -sk -X DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/empty
        echo
        echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/9
        curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/9
        echo
        echo POST -H "Content-Type: application/json" -d @login_request1.json ${PROTOCOL}://${HOST}/login
        curl -sk -X POST -H "Content-Type: application/json" -d @login_request1.json ${PROTOCOL}://${HOST}/login
        echo
        echo GET ${PROTOCOL}://${HOST}/products/all
        curl -sk -X GET ${PROTOCOL}://${HOST}/products/all
    done
done







