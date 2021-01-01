# Minecraft Server (vagrant)

1. Create symlinks some of the assets in the project root
```
ln -s ../*.json .
ln -s ../server.jar .
```
1. Run `vagrant up` to create the VM and initiate the provisioning process.
1. If the provisioning needs to be run again (or fails to complete, or whatever), you can use `vagrant provision` to execute only the ansible portion.
1. Connect with your Minecraft client to localhost.
