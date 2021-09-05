#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1
cd terraform
terraform destroy -var "pvt_key=~/.ssh/id_rsa" -var "pub_key=~/.ssh/id_rsa.pub" -auto-approve
echo terraformDestroyStatus=$?
if [! ["$terraformDestroyStatus]]
	then
		echo "Infrastructure destroyed successfully with terraform destroy command!!"
	else
		echo "Infrastructure destruction failed. Please check terraform logs!!
fi
