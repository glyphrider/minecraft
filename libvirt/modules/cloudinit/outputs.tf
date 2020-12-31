output "id" {
    description = "Terraform id of the cloudinit iso"
    value = libvirt_cloudinit_disk.init.id
}
