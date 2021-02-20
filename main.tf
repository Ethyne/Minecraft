terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS 8.*x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["125523088429"] # Canonical
}


resource "aws_instance" "minecraft" {
  ami = data.aws_ami.centos.id
  instance_type = "t2.medium"
  
  tags = {
    Application = "Minecraft"
  }
}
