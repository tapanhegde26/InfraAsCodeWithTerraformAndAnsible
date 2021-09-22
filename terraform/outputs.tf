output "address" {
  value = "http://${aws_instance.web.public_ip}/mediawiki/"
}

output "ssh" {
  value = "ssh ${local.vm_user}@${aws_instance.web.public_ip}"
}


