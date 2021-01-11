# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"
  name = "minecraft"
}

resource "aws_security_group" "ssh_sg" {
  name = "ssh-sg"
  vpc_id = module.vpc.id

  ingress {
    description = "ssh-ingress"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "minecraft_sg" {
  name = "minecraft-sg"
  vpc_id = module.vpc.id
  
  ingress {
    description = "minecraft-ingress"
    from_port = 25565
    to_port = 25565
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "out_sg" {
  name = "open-egress-sg"
  vpc_id = module.vpc.id

  egress {
    description = "open-egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "user_data" {
  template = file("../cloudinit.yml")
}

module "minecraft_ami" {
  source = "./modules/amazon_linux"
}

resource "aws_instance" "minecraft" {
  ami           = module.minecraft_ami.id
  instance_type = "t3.xlarge"
  subnet_id     = module.vpc.public_subnet_id
  user_data     = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id, aws_security_group.ssh_sg.id, aws_security_group.out_sg.id ]

  tags = {
    Name = "minecraft-server"
  }
}
