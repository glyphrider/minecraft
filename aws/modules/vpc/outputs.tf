output "id" {
  description = "ID of the requested VPC"
  value = aws_vpc.vpc.id
}

output "private_subnet_id" {
  description = "ID of the public subnet"
  value = aws_subnet.private_subnet.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value = aws_subnet.public_subnet.id
}
