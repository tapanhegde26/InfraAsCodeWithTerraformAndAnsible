# InfrastructureAsCode With Terraform And Ansible
In this repo, I tried to develop infrastructure on aws with help of terraform and then tried to achieve configuration management using ansible

## Table of contents
* [Details](#details)
* [Technologies](#technologies)
* [Operating-System](#operating-system)
* [Pre-requisite](#pre-requisite)
* [Set-up](#set-up)
* [Usage](#usage)
  * [Notes](#notes)
* [output](#output)
* [Project-status](#project-status)
* [Future-improvement](#future-improvement)
* [Challenges](#challenges)
* [Credits&References](#credits&references)

## Details
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
  * ansible/Files/httpd.conf.j2 :- Template file for apache(httpd) server config
  * ansible/Files/info.php.j2 :- Template file for sample info.php
  * ansible/vars/default.yml :- contains variables, which references are used in main ansible yml file
  * ansible/ansible.cfg :- config file for ansible
  * terraform/aws.tf :- This file contains cloud provider details for terraform
  * terraform/ec2.tf :- This file contains details for ec2 instance creation
  * ansible/install_mediawiki.sh :- bash script to install mediawiki in created ec2 instance, this script is invoked in ansible playbook command
  * ansible/install_module.sh :- bash script to reset/enable php modules in ec2 instance
  * terraform/output.tf :- This file will have public ip of ec2 instance once creation is success.
  * terraform/vars.tf :- This file contains variables for terraform
  * terraform/vpc.tf :- This file contains network details for ec2 instance
  * createInfra.sh :- This script contains terraform commands to create EC2 infra in aws
  * destroyInfra.sh :- This script contains terraform commands to destroy EC2 infra in aws
  
To run this project, execute below commands.
  * clone this project
    ```
      $ git clone https://github.com/sheldon-cooper26/InfraAsCodeWithTerraformAndAnsible.git  
    ```
  * go to directory 'InfraAsCodeWithTerraformAndAnsible'
    ```
      $ cd InfraAsCodeWithTerraformAndAnsible
  
    ```
  * execute createInfra script
    ```
      $ chmod +x createInfra.sh
      $ ./createInfra.sh
    ```
 
 ### Notes:
   * Here i am considering path for ssh keys would be /home/user/.ssh path, you can generate and keep ssh keys in any path and make sure you use same path while running terraform apply commmand
   * I am considering us-east-1 as default region, same has been set in createInfra.sh and destroyInfra.sh scripts. Please feel free to change it according to your feasibility.

## output
When createInfra.sh executes successfully, you will get similar below message on console.
```
address = "http://54.159.90.179/mediawiki/mediawiki-1.36.1/index.php/Main_Page"
ssh = "ssh ec2-user@54.159.90.179"
Infra created
```
try to access above mediawiki url : http://[public-ip]/mediawiki/mediawiki-1.36.1/index.php/Main_Page
* Eg : http://54.159.90.179/mediawiki/mediawiki-1.36.1/index.php/Main_Page
* you should see setup mediawiki page as below
    ![alt text](https://github.com/sheldon-cooper26/InfraAsCodeWithTerraformAndAnsible/blob/main/image.png?raw=true)
  
## Project-status
    In-progress
    
## Challenges
* with this automation I was only able to install mediawiki in ec2-instance. But, complete setup requires manual intervention, like we need to set language, add db details for wiki manually by following web instructions. Need to find a way to automate this, so that complete installation+configuration suite can be automated.

## Future-improvment
This project can be improved in below areas.
* Ansible variables handling :
    * I am working to upgrade this project by using ansible vault to store db credentials in encrypted format

* Terraform file declaration :
    * Modules can be created and these module templates can be used in main.tf which is used ec2-instance creation.
    * Load balancing of instance can be achieved
    * Blue-green and canary deployment can be achieved
    
* For now this project is tested only for AWS cloud, it can be extended to other cloud providers like GCP, Azure, Digital Ocean etc

* For now this project is tested with RHEL-8 ami image, it can fine tuned to use other linux flavours like ubuntu, amazon linux, suse etc.
* mediawiki site is running on http protocol(not secure) by default, we can make necessary changes at httpd web server level to make it secure(https)


## Credits & References
https://www.digitalocean.com/community/tutorials/how-to-use-ansible-with-terraform-for-configuration-management
https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started
https://docs.ansible.com/ansible/2.3/list_of_all_modules.html
https://www.linuxtechi.com/install-mediawiki-on-linux/
https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Red_Hat_Linux
  



   

