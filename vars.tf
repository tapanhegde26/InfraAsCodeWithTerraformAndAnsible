variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "key_name" {
  default = "terraform-ansible-example-key"
}

variable "tags" {
  type = string
  default = "th-tag"
}
variable "pvt_key" {}
variable "pub_key" {}
