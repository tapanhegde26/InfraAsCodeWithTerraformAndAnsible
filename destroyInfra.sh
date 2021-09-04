#!/bin/bash

cd terraform
terraform destroy -var "pvt_key=~/.ssh/id_rsa" -var "pub_key=~/.ssh/id_rsa.pub" -auto-approve
echo "Infra is destroyed"
