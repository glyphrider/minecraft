resource "libvirt_volume" "main" {
  name = "${var.instance_name}.qcow2"
  pool = "default"
  base_volume_name = var.base_volume_name
  size = var.disk
  format = "qcow2"
}

resource "libvirt_domain" "host" {
  name   = var.instance_name
  memory = var.memory
  vcpu   = var.vcpu

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.main.id
  }

  cloudinit = var.cloudinit_id

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

