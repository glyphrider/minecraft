data "aws_ami" "ami" {
  most_recent = true

  filter {
    name = "name"
    values = [var.name]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.owner]
}
