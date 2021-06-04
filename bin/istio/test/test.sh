#!/usr/bin/env bash

HOST=kong-$1.istio.dev1.eks.openshiftlabs.net/amazin

PROTOCOL=https

for i in $(seq 1 1000)
do
    echo Iteration \# ${i}
    echo POST -H "Content-Type: application/json" -d @login_request1.json ${PROTOCOL}://${HOST}/login
    curl -sk -X POST -H "Content-Type: application/json" -d @login_request1.json ${PROTOCOL}://${HOST}/login
   echo
#    echo POST -H "Content-Type: application/json" -d @login_request_broken.json ${PROTOCOL}://${HOST}/login
#    curl -sk -X POST -H "Content-Type: application/json" -d @login_request_broken.json  ${PROTOCOL}://${HOST}/login
#     echo
    cat login_request1.json | sed s/test/test${i}/ > login_request_next.json
    echo POST -H "Content-Type: application/json" -d @login_request_next.json ${PROTOCOL}://${HOST}/login
    BASKET=$(curl -sk -X POST -H "Content-Type: application/json" -d @login_request_next.json ${PROTOCOL}://${HOST}/login | jq .basketId)
    echo *****BASKET : ${BASKET}

    echo GET ${PROTOCOL}://${HOST}/products/all
    curl -sk -X GET ${PROTOCOL}://${HOST}/products/all
    echo
    echo GET ${PROTOCOL}://${HOST}/products/7
    curl -sk -X GET ${PROTOCOL}://${HOST}/products/7
#    echo
#    echo  GET ${PROTOCOL}://${HOST}/products/19
#    curl -sk -X GET ${PROTOCOL}://${HOST}/products/19
#    echo
#    echo GET ${PROTOCOL}://${HOST}/prod/19
#    curl -sk -X GET ${PROTOCOL}://${HOST}/prod/19
#    echo
#    echo GET ${PROTOCOL}://${HOST}/products/19
#    curl -sk -X GET ${PROTOCOL}://${HOST}/products/19
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
#    echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/19
#    curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/19
#    echo
#    echo PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/anything
#    curl -sk -X PUT ${PROTOCOL}://${HOST}/basket/${BASKET}/add/anything
    echo
    echo DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
    curl -sk -X DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
#     echo
#    echo DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
#    curl -sk -X DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
#    echo
#    echo DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
#    curl -sk -X DELETE ${PROTOCOL}://${HOST}/basket/${BASKET}/remove/1
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







