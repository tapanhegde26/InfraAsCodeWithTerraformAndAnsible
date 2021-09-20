locals {
  # The default username for our AMI
  # vm_user = "ec2-user"
  vm_user = "ubuntu"
}

# Get the latest redhat 8 AMI
#data "aws_ami" "redhat-linux-8" {
#  most_recent = true
#  owners      = ["309956199498"]
#  filter {
#    name   = "name"
#    values = ["RHEL-8.*"]
#  }
#}

# Get the latest ubuntu 18 AMI
data "aws_ami" "ubuntu-linux-1804" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "${data.aws_ami.ubuntu-linux-1804.id}"

  # The name of our SSH keypair
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  subnet_id = "${aws_subnet.default.id}"

  # force Terraform to wait until a connection can be made, so that Ansible doesn't fail when trying to provision
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install python3 -y",
      "echo ${aws_instance.web.public_ip}"
    ]
   connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.pvt_key)
    }
    }
   provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' ~/InfraAsCodeWithTerraformAndAnsible/ansible/allDistros.yml --vault-password-file ~/InfraAsCodeWithTerraformAndAnsible/.vault"
  }

}

