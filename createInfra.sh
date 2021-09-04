#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1
cd terraform
terraform init
terraform apply -var "pvt_key=~/.ssh/id_rsa" -var "pub_key=~/.ssh/id_rsa.pub" -auto-approve
echo "Infra created"
