# InfrastructureAsCode With Terraform And Ansible
In this repo, I tried to develop infrastructure on aws with help of terraform and then tried to achieve configuration management using ansible

## Details :
This repository sets up:

* A VPC
* A subnet
* An internet gateway
* A security group
* An SSH key pair
* A publicly-accessible EC2 instance

Following contents will be deployed/installed in instance
  * Python 3 (for Ansible)
  * LAMP stack
  * Mediawiki-1.36

## Technologies
Project is created with:
* AWS
* Ansible: 2.9
* Terraform: 1.0.5

## Operating System
* Redhat 8

## Pre-requisite
* An AWS Account
* An AWS CLI needs to be installed
* Your AWS credentials. 
  * You can create a new Access Key on this page.https://console.aws.amazon.com/iam/home?#/security_credentials

## set-up
* Install Python3, Terraform, Ansible locally.
   * Python3 : https://linuxconcept.com/how-to-install-python-3-on-rhel-8-red-hat-enterprise-linux/
   * Terraform : https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
   * Ansible : https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04
* Set up AWS credentials in ~/.aws/credentials.
   * The easiest way to do so is by setting up the AWS CLI. https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

## Usage
* Files used in this project with their functionality listed
  * Files/httpd.conf.j2 :- Template file for apache(httpd) server config
  * Files/info.php.j2 :- Template file for sample info.php
  * vars/default.yml :- contains variables, which references are used in main ansible yml file
  * ansible.cfg :- config file for ansible
  * aws.tf :- This file contains cloud provider details for terraform
  * ec2.tf :- This file contains details for ec2 instance creation
  * install_mediawiki.sh :- bash script to install mediawiki in created ec2 instance, this script is invoked in ansible playbook command
  * install_module.sh :- bash script to reset/enable php modules in ec2 instance
  * output.tf :- This file will have public ip of ec2 instance once creation is success.
  * vars.tf :- This file contains variables for terraform
  * vpc.tf :- This file contains network details for ec2 instance

To run this project, execute below commands.
  * clone this project
    ```
      $ git clone https://github.com/sheldon-cooper26/InfraAsCodeWithTerraformAndAnsible.git  
    ```
  * go to directory 'InfraAsCodeWithTerraformAndAnsible'
    ```
      $ cd InfraAsCodeWithTerraformAndAnsible
  
    ```
  * Set default region
    ```
    export AWS_DEFAULT_REGION=us-east-1
    ```
  * initialize terraform
    ```
      $ terraform init  
    ```
  * execute terraform apply with private/public key path
    ```
      $ terraform apply -var "pvt_key=~/.ssh/id_rsa" -var "pub_key=~/.ssh/id_rsa.pub"
    ``` 
  here i am considering path for ssh keys would be /home/user/.ssh path, you can generate and keep ssh keys in any path and make sure you use same path while running terraform apply commmand
  
## Project status
    In-progress
    
## Room for improvment
This project can be improved in below areas.
* Ansible variables handling :
    * I am planning to upgrade this project by using ansible vault to store db credentials in encrypted format

* Terraform file declaration :
    * Modules can be created and these module templates can be used in main.tf which is used ec2-instance creation.
    * Load balancing of instance can be achieved
    * Blue-green and canary deployment can be achieved
    
* For now this project is tested only for AWS cloud, it can be extended to other cloud providers like GCP, Azure, Digital Ocean etc

* For now this project is tested with RHEL-8 ami image, it can fine tuned to use other linux flavours like ubuntu, amazon linux, suse etc.
  



   

