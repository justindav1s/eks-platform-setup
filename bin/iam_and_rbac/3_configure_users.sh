#!/bin/bash

aws iam add-user-to-group --group-name k8sAdmin --user-name mike.croft
aws iam add-user-to-group --group-name k8sAdmin --user-name richard.walker
aws iam add-user-to-group --group-name k8sAdmin --user-name justindav1s

aws iam get-group --group-name k8sAdmin
aws iam get-group --group-name k8sDev
aws iam get-group --group-name k8sInteg

aws iam create-access-key --user-name mike.croft | tee ~/aws/mike.croft.json
aws iam create-access-key --user-name richard.walker | tee ~/aws/richard.walker.json
aws iam create-access-key --user-name justindav1s | tee ~/aws/justindav1s.json