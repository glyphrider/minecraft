module "cloudinit" {
    source = "./modules/cloudinit"
    template_file = "${path.cwd}/../cloudinit.yml"
}

module "minecraft" {
    source = "./modules/host"
    instance_name = "minecraft"
    memory = 16384
    vcpu = 2
    disk = 8*1024*1024*1024
    cloudinit_id = module.cloudinit.id
    base_volume_name = "bionic-server-cloudimg-amd64.img"
}

output "minecraft" {
    value = module.minecraft.ip_address
}
