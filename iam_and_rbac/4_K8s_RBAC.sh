#!/bin/bash

cat << EOF | kubectl apply -f - -n team2-dev
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: dev-role
rules:
  - apiGroups:
      - ""
      - "apps"
      - "batch"
      - "extensions"
    resources:
      - "configmaps"
      - "cronjobs"
      - "deployments"
      - "events"
      - "ingresses"
      - "jobs"
      - "pods"
      - "pods/attach"
      - "pods/exec"
      - "pods/log"
      - "pods/portforward"
      - "secrets"
      - "services"
    verbs:
      - "create"
      - "delete"
      - "describe"
      - "get"
      - "list"
      - "patch"
      - "update"
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: dev-role-binding
subjects:
- kind: User
  name: dev-user
roleRef:
  kind: Role
  name: dev-role
  apiGroup: rbac.authorization.k8s.io
EOF

cat << EOF | kubectl apply -f - -n team2-e2e
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: e2e-role
rules:
  - apiGroups:
      - ""
      - "apps"
      - "batch"
      - "extensions"
    resources:
      - "configmaps"
      - "cronjobs"
      - "deployments"
      - "events"
      - "ingresses"
      - "jobs"
      - "pods"
      - "pods/attach"
      - "pods/exec"
      - "pods/log"
      - "pods/portforward"
      - "secrets"
      - "services"
    verbs:
      - "create"
      - "delete"
      - "describe"
      - "get"
      - "list"
      - "patch"
      - "update"
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: e2e-role-binding
subjects:
- kind: User
  name: e2e-user
roleRef:
  kind: Role
  name: e2e-role
  apiGroup: rbac.authorization.k8s.io
EOF

eksctl create iamidentitymapping \
  --cluster dev1 \
  --arn arn:aws:iam::${AWS_ACCOUNT}:role/k8sDev \
  --username dev-user

eksctl create iamidentitymapping \
  --cluster dev1 \
  --arn arn:aws:iam::${AWS_ACCOUNT}:role/k8sInteg \
  --username e2e-user

eksctl create iamidentitymapping \
  --cluster dev1 \
  --arn arn:aws:iam::${AWS_ACCOUNT}:role/k8sAdmin \
  --username justindav1s \
  --group system:masters

eksctl create iamidentitymapping \
  --cluster dev1 \
  --arn arn:aws:iam::${AWS_ACCOUNT}:role/k8sAdmin \
  --username mike.croft \
  --group system:masters

eksctl create iamidentitymapping \
  --cluster dev1 \
  --arn arn:aws:iam::${AWS_ACCOUNT}:role/k8sAdmin \
  --username richard.walker \
  --group system:masters  