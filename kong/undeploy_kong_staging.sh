#!/bin/bash

NS=staging

helm uninstall $NS -n kong-$NS