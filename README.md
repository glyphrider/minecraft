# Minecraft Server

1. Install and configure [Oracle VirtualBox](https://virtualbox.org)
1. Install and configure [Vagrant](https://vagrantup.com)
1. Install and configure [Ansible](https://www.ansible.com) -- something like `pip3 install --user ansible`
1. Download the server.jar from [Minecraft](https://www.minecraft.net/en-us/download/server) and place it in this directory
1. Run `vagrant up`
1. Select the appropriate adapter for _public network_ bridging
1. Run `vagrant ssh` and once in the VM, type `ip a` to discover the IP address of your server (or do any one of a million other little tricks to figure that out)
1. Connect to the server's IP address with the Minecraft client

If you want to read about the craziness of making this work with Terraform and libvirt, go [here](libvirt.md).
