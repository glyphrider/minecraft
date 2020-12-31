data "template_file" "user_data" {
  template = file(var.template_file)
}

resource "random_id" "iso" {
  byte_length = 6
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "init" {
  name = format("%s.iso",random_id.iso.hex)
  user_data = data.template_file.user_data.rendered
}
