#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1
cd terraform
terraform init
terraform apply -var "pvt_key=~/.ssh/id_rsa" -var "pub_key=~/.ssh/id_rsa.pub" -auto-approve
export terraformApplyStatus=$?
if [ !["$terraformApplyStatus"]]
	then
		echo "Infrastructure created successfully using terraform apply command!!"
	else
		echo "Infrastructure creation failed. Check terraform apply logs!!"
fi
