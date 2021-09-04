output "address" {
  value = "http://${aws_instance.web.public_ip}/mediawiki/mediawiki-1.36.1/index.php/Main_Page"
}

output "ssh" {
  value = "ssh ${local.vm_user}@${aws_instance.web.public_ip}"
}


