# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.47.0.0/16"
  tags = {
    Name = "bhw-vpc"
  }
  # count = 1 # "${var.use_existing_vpc == "" ? 1 : 0}"
}

resource "aws_security_group" "ssh_sg" {
  name = "ssh-sg"
  vpc_id = aws_vpc.vpc.id

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
  vpc_id = aws_vpc.vpc.id
  
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
  vpc_id = aws_vpc.vpc.id

  egress {
    description = "open-egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.47.0.0/24"
tags = {
    Name = "minecraft-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
tags = {
    Name = "minecraft-gw"
  }
}
resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "default route table"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "user_data" {
  template = file("cloudinit.yml")
}

resource "aws_instance" "minecraft" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.xlarge"
  subnet_id     = aws_subnet.subnet.id
  associate_public_ip_address = true
  user_data     = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id, aws_security_group.ssh_sg.id, aws_security_group.out_sg.id ]

  tags = {
    Name = "minecraft-server"
  }
}

output "server" {
  value = aws_instance.minecraft.public_ip
}
