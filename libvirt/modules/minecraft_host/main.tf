module "cloudinit" {
  source = "../cloudinit"
  template_file = "${path.cwd}/../cloudinit.yml"
}

module "host" {
  source = "../host"
  instance_name = "minecraft"
  memory = 16384
  vcpu = 8
  disk = 8*1024*1024*1024
  cloudinit_id = module.cloudinit.id
  base_volume_name = var.base_volume_name
}
