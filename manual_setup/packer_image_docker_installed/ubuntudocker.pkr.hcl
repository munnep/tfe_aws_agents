variable "region" {
  type    = string
  default = "eu-north-1"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntudocker2" {
  ami_name      = "ubuntudocker2"
  instance_type = "t3.small"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name = "ubuntu/images/*ubuntu-focal-*-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "ubuntudocker2"
  sources = [
    "source.amazon-ebs.ubuntudocker2",
  ]

  provisioner "shell" {
     script = "scripts/install_docker.sh"
  }
}