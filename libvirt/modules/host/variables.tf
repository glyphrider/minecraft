variable "instance_name" {
    description = "Name of the libvirt/kvm instance."
    type = string
}

variable "memory" {
    description = "Memory in megabytes"
    type = number
    default = 2048
}

variable "vcpu" {
    description = "Number of virtual CPUs"
    type = number
    default = 1
}

variable "disk" {
    description = "Size of main disk in gigabytes"
    type = number
    default = 4294967296
}

variable "base_volume_name" {
    description = "Name of the cloud image to back the storage for this host"
    type = string
}

variable "cloudinit_id" {
    description = "Terraform id of the cloudinit iso"
    type = string
}
