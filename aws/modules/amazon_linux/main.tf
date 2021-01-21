module "ami" {
  source     = "../ami"
  owner      = "amazon"
  name       = "amzn2-ami-hvm*"
}
