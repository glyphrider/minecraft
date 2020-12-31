output "id" {
    description = "ID of the requested AMI"
    value = data.aws_ami.ami.id
}
