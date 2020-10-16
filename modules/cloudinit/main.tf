data "template_file" "user_data" {
  template = file(var.template_file)
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "init" {
  name = "cloudinit.iso"
  user_data = data.template_file.user_data.rendered
}
