#!/bin/bash


#export GPG_KEY_NAME="cluster1.kubernetes.docker.internal"
export KEY_COMMENT="flux secrets $(date "+%d-%m-%Y %H:%M:%S")"

gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${GPG_KEY_NAME}
EOF

gpg --list-secret-keys "${GPG_KEY_NAME}"