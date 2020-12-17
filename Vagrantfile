# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  # config.vm.network "public_network"
  config.vm.network "forwarded_port", guest: 25565, host: 25565, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 25565, host: 25565, protocol: "udp"
  config.vm.network "forwarded_port", guest: 19132, host: 19132, protocol: "udp"
  config.vm.network "forwarded_port", guest: 19133, host: 19133, protocol: "udp"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "minecraft"
    vb.memory = "8192"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yml"
  end
end
