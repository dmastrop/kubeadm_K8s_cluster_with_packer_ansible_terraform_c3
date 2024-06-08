terraform {
  required_providers {
    aws = { version = "~> 4.0" }
  }
} 

provider "aws" {
  region  = "us-east-1"
}
terraform {
   backend "s3" {
    #bucket = "# Add your S3 bucket here"
    bucket = "course3-kubeadm-terraform-state"
    key    = "default.tfstate"
    region = "us-east-1"
  }
}
module "kubernetes" {
  source = "./kubernetes"
  # this is the AMI id of the packer/ansible created node/master image created earlier
  ami = "ami-0704ecf0bdb63417e"
  cluster_name = "basic-cluster"
  master_instance_type = "t3.medium"
  nodes_max_size = 1
  nodes_min_size = 1
  private_subnet01_netnum = "1"
  public_subnet01_netnum = "2"
  region = "us-east-1"
  vpc_cidr_block = "10.240.0.0/16"
  worker_instance_type = "t3.medium"
  vpc_name = "kubernetes"
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyRfQuy8VSZLn+ZX2qIlBGCzV9a6q68udgT9GoBIIYMu/NiBbMBNjt31BI+oP7bYSus1irrUKN0T7tyPEzKhLp7exdaii/7eFKI1n0RoucP9IqAx1xfXy6KUE6Nd9P6Ct2pjiLKCWzpDYx77SsoPlgn273eGXRgShdw6Qaj3vkcw6UJFbSK75SeQSK2ei17M+CUN+xvx85F8rohi+hqt5OraErgwmaOKUtS5W/5zO3w9wk+ksLBut/ltxqu8FRO79XiIhuzTOGfXFbHAN94Oni6oluvl62mDr5paJVhv++Iz4ImQcqH9aBd0uHLxa496Sd1EPeEiky62+Y1bm7WOpJOqmkMwu2GN4nNLTqwbS1UQTbtJHtObyIOM/HbT7s1P5OoaBKJbpQQ47C3F8AbbBo6AHi4RtACbGJdLdoribq32lKz6QGJ1Te8vPfIkh0wSy/5MnrmMjf98MU2cjct0MBl8UXF9e6mzdTh3fpoCAyMfoxNcAMh5CNldbQ6Px3XnE= ubuntu@ip-172-31-20-161"
}
