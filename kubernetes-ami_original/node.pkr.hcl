source "amazon-ebs" "ubuntu" {
  ami_name      = "k8s-node"
  instance_type = "t3.micro"
  region        = "eu-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  force_deregister = true
  force_delete_snapshot = true
}

build {
  name    = "k8s-node"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "ansible" {
    playbook_file = "./ansible/playbook.yaml"
  }
}
