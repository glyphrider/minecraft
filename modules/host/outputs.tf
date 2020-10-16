output "ip_address" {
    description = "IP Address of the new instance"
    value = libvirt_domain.host.network_interface.0.addresses.0
}
