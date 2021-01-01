# Minecraft Server (libvirt)

1. Create symlinks some of the assets in the project root
```
ln -s ../*.json .
ln -s ../server.jar .
```
1. Run `terraform init` to acquire needed plugins and providers.
1. Run `terraform apply` to create the infrastructure.
1. Run `ansible-playbook minecraft.yml` to provision the minecraft server.
1. Use `terraform output` to acquire the public IP address of the server.
1. Connect with your Minecraft client
