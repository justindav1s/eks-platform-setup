#!/bin/bash

flux create source git flux-sops-secrets \
--url=ssh://git@github.com/justindav1s/flux-sops-secrets \
--branch=main \
--private-key-file=/Users/justin/.ssh/id_rsa


flux create kustomization flux-sops-secrets \
--source=flux-sops-secrets \
--path=./clusters/shop-dev-k8s \
--prune=true \
--interval=10m \
--decryption-provider=sops \
--decryption-secret=flux-sops-gpg \
--export > ../../clusters/shop-dev-k8s/flux-sops-secrets.yaml