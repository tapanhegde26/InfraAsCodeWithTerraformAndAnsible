#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1
cd terraform
terraform destroy -var "pvt_key=~/.ssh/id_rsa" -var "pub_key=~/.ssh/id_rsa.pub" -auto-approve
echo terraformDestroyStatus=$?
if [[ "$terraformDestroyStatus" -ne 0 ]]; then
	echo "Infrastructure destruction failed. Please check terraform logs!!"
else
	echo "Infrastructure destroyed successfully with terraform destroy command!!"
fi
