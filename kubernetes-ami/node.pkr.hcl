packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2.1"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
// https://developer.hashicorp.com/packer/integrations
}

source "amazon-ebs" "ubuntu" {
// amazon ami image based on ubuntu
  ami_name      = "k8s-node"
  instance_type = "t3.micro"
  //region        = "eu-west-2"
  region        = "us-east-1"
  //source_ami base http://cloud-images.ubuntu.com/locator/ec2/
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    //cannanocal
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
    //playbook file provided.
  }
}
