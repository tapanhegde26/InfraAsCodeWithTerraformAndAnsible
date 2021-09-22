# Infrastructure-As-Code With Terraform And Ansible
In this repo, I tried to develop infrastructure on aws with help of terraform and then tried to achieve configuration management using ansible.

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
* [References](#references)

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
* Ansible: 2.9.25
* Terraform: 1.0.5

## Operating-System
* Redhat 8
* Ubuntu 20.04 LTS

## Pre-requisite
* An AWS Account
* An AWS CLI needs to be installed
* Your AWS credentials. 
  * You can create a new Access Key on this page.[link](https://console.aws.amazon.com/iam/home?#/security_credentials)

## Set-up
* Git needs to be installed in host machine
   * [git](https://linuxconfig.org/install-git-in-linux-redhat-8)
* Install Python3, Terraform, Ansible locally.
   * [Python3 installation](https://linuxconcept.com/how-to-install-python-3-on-rhel-8-red-hat-enterprise-linux/)
   * Terraform : 
      * [Download Terraform](https://www.terraform.io/downloads.html)
      * [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
   * Ansible : Install ansible on host machine
      * [Ansible installation](https://www.decodingdevops.com/how-to-install-ansible-on-rhel-8/)
      * [ubuntu ansible installation](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-18-04)
* Set up AWS credentials in ~/.aws/credentials.
   * The easiest way to do so is by setting up the AWS CLI. 
      * [Install CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
      * [Install CLI on linux](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)
* once aws-cli is installed in host machine, set up aws credentials using below command
   ```
   $ aws configure
   ```
   * This will ask for your AWS access key and AWS Secret as below
      - AWS Access Key ID [None] : ******
      - AWS Secret Access Key [None] : ******
      - Default region name : [leave it none , press enter]
      - Default output format : [leave it none, press enter]
* Generate ssh keys for your host machine and save it under path '/home/[user]/.ssh'
   * [Link to generate ssh keys](https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-rhel-8/)

## Usage
* Files used in this project with their functionality listed
  * ansible/Files/httpd.conf.j2 :- Template file for apache(httpd) server config
  * ansible/Files/info.php.j2 :- Template file for sample info.php
  * ansible/vars/default.yml :- contains variables, which references are used in main ansible yml file
  * ansible/ansible.cfg :- config file for ansible
  * ansible/allDistros.yml :- yml file to install lamp stack on redhat/ubuntu image
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
   * Here i am considering path for ssh keys would be /home/user/.ssh path, you can generate and keep ssh keys in any path and make sure you use same path while running terraform apply command
   * I am considering us-east-1 as default region, same has been set in createInfra.sh and destroyInfra.sh scripts. Please feel free to change it according to your feasibility.

## Output
When createInfra.sh executes successfully, you will get similar below message on console.
```
address = "http://ec2-54-175-133-129.compute-1.amazonaws.com/mediawiki/"
ssh = "ssh ec2-user@34.226.196.34"
Infrastructure created successfully using terraform apply command!!
```
try to access above mediawiki url : http://[public-ip]/mediawiki/
* Eg : http://ec2-54-175-133-129.compute-1.amazonaws.com/mediawiki/
* you should see setup mediawiki page as below
    ![alt text](https://github.com/sheldon-cooper26/InfraAsCodeWithTerraformAndAnsible/blob/main/image.png?raw=true)
  
## Project-status
    In-progress
    
## Challenges
* with this automation I was only able to install mediawiki in ec2-instance. But, complete setup requires manual intervention, like we need to set language, add database details for wiki manually by following web instructions. Need to find a way to automate this, so that complete installation+configuration suite can be automated.

## Future-improvement
This project can be improved in below areas.
* Ansible variables handling 
    * I am working to upgrade this project by using ansible vault to store db credentials in encrypted format [completed]
        * encrypted vars/default.yml file using anisble-vault. please find below command to execute ansible playbook using vault password file
            ```
            ansible-playbook -i inventory allDistros.yml
            ```
    * Update 
      * Now Ansible vault is integrated with gpg key to make it more secure. Earlier password was kept in .vault file and this file is committed in git repo (which is very bad practice). 
      * Now, gpg key is configured and it is encrypted and this encrypted key is used as ansible-vault password.
     
    Reference : [Secrets with Ansible: Ansible Vault and GPG](https://benincosa.com/?p=3235)

* Terraform file declaration :
    * Modules can be created and these module templates can be used in main.tf which is used ec2-instance creation.
    * Load balancing of instance can be achieved
    * Blue-green and canary deployment can be achieved
    
* For now this project is tested only for AWS cloud, it can be extended to other cloud providers like GCP, Azure, Digital Ocean etc

* For now this project is tested with RHEL-8 ami image, it can fine tuned to use other linux flavours like ubuntu, amazon linux, suse etc.

    * Update : 
        
        * Now this functionality is extended to both RedHat image and Ubuntu image. Refere allDistros.yml for references.
        
        * Next, I am planning to create automation in terraform files to pick proper image depending on condition.
  
* mediawiki site is running on http protocol(not secure) by default, we can make necessary changes at httpd web server level to make it secure(https)

## Notes:

* If you are using fresh machine and ansible is newly installed in that machine, then while running ansible command you might face below error
     * "ERROR! couldn't resolve module/action 'community.mysql.mysql_user'. This often indicates a misspelling, missing collection, or incorrect module path."
     * To resolve this error, you need to install community.mysql from ansible-galaxy collection
    
    ```
    $ ansible-galaxy collection install community.mysql
    
    ```


## References
* [how to use ansible with terraform on Digital ocean](https://www.digitalocean.com/community/tutorials/how-to-use-ansible-with-terraform-for-configuration-management)
* [hasicorp tutorials](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started)
* [Ansible documentation](https://docs.ansible.com/ansible/2.3/list_of_all_modules.html)
* [install mediawiki on linux](https://www.linuxtechi.com/install-mediawiki-on-linux/)
* [mediakwiki manual - RedHat](https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Red_Hat_Linux)
* [mediawiki manual - ubuntu](https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Debian_or_Ubuntu)
  



   

