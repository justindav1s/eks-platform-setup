#!/bin/bash

KEY_FP=$(gpg --list-secret-keys "${GPG_KEY_NAME}" | sed '2q;d' | sed 's/ *$//g')

echo KEY_FP=$KEY_FP

gpg --export-secret-keys --armor "${KEY_FP}"

gpg --export-secret-keys --armor "${KEY_FP}" |
kubectl create secret generic flux-sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin