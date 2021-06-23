#!/bin/bash

NS=secret-test

Kubectl delete ns $NS

sleep 5 
kubectl create ns $NS

eksctl create iamserviceaccount \
    --name aws-secret-reader \
    --namespace $NS \
    --cluster dev1 \
    --attach-policy-arn arn:aws:iam::aws:policy/SecretsManagerReadWrite \
    --approve \
    --override-existing-serviceaccounts


cat <<EOF | kubectl -n $NS apply -f -
apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
kind: SecretProviderClass
metadata:
  name: aws-secrets
  namespace: ${NS}
spec:
  provider: aws
  parameters:
    objects:  |
      - objectName: "MySecret2"
        objectType: "secretsmanager"
EOF

cat <<EOF | kubectl -n $NS apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: nginx-secrets-store-inline
spec:
  serviceAccountName: aws-secret-reader
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
    - name: mysecret2
      mountPath: "/mnt/secrets-store"
      readOnly: true
  volumes:
    - name: mysecret2
      csi:
        driver: secrets-store.csi.k8s.io
        readOnly: true
        volumeAttributes:
          secretProviderClass: "aws-secrets"
EOF