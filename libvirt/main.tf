module "minecraft" {
    source = "./modules/amazon_linux"
}

output "minecraft" {
    value = module.minecraft.ip_address
}
