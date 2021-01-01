module "minecraft" {
    source = "./modules/bionic"
}

output "minecraft" {
    value = module.minecraft.ip_address
}
