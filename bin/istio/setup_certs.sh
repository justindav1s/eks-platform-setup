rm -rf *192.168.28.136*

APP=kong-staging.istio.dev1.eks
DOMAIN=openshiftlabs.net

rm -rf *${DOMAIN}*

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=Kong Inc./CN=${DOMAIN}' -keyout ${DOMAIN}.key -out ${DOMAIN}.crt

openssl req -out ${APP}.${DOMAIN}.csr -newkey rsa:2048 -nodes -keyout ${APP}.${DOMAIN}.key -subj "/CN=${APP}.${DOMAIN}/O=${APP} organization"
openssl x509 -req -days 365 -CA ${DOMAIN}.crt -CAkey ${DOMAIN}.key -set_serial 0 -in ${APP}.${DOMAIN}.csr -out ${APP}.${DOMAIN}.crt

sleep ${SLEEP}

kubectl create -n istio-system secret tls kong-tls-credentials --key=${APP}.${DOMAIN}.key --cert=${APP}.${DOMAIN}.crt

rm -rf *${DOMAIN}*
