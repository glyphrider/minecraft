# Minecraft

Built to work with libvirt (local Linux VMs).

# How to...

## Do Once...

### Get qemu, kvm, and libvirt all working

Not covered here.

### Install terraform and ansible

Not covered here.

### Install Go[Lang]

Not covered here.

### Install the libvirt provider for terraform

This is more complicated than it should be, thanks to terraform 0.13. Down load the _release_ from [here](https://github.com/dmacvicar/libvirt).
I scored version 0.6.2, but YMMV. Copy the executable (just the executable) to
`~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64/terraform-provider-libvirt`.
The astute among you will recognize how parts of that path are put together.
If your version is not 0.6.2, adjust that part of the path.
There are very specific parts of that path which also appear in the `provider.tf` file.
If your version is not 0.6.2, adjust that in the provider.tf file as well.
Together, all this should allow the manually installed plugin to function with the new terraform.

### Terraform Init

To make sure the plugin is installed and configured correctly, execute

```
terraform init
```

This should process the provider.tf file, as well as the other .tf files, and wire everything up to the provider.

### Create an ssh-key pair

Create an ssh-key pair for use with your automation. If you already have a key-pair you wish to use, it should be fairly obvious how to inject it
into this recipe without the following

```
ssh-keygen -f ansible -C 'my minecraft automation key'
```

You can actually use any file for the key (it doesn't have to be ansible), and of course, you can make the comment read whatever you like.
At this point, I find it useful to add the private key to my ssh-agent.

```
ssh-add ansible
```

### Cloud-Init

Now, let's use ansible to build our cloudinit.cfg, so we can use cloud-init to customize the ubuntu cloud image.

```
ansible-playbook generate-cloudinit.ym -e 'SSH_USER=ansible SSH_KEY_FILE=ansible.pub'
```

If you key file has a different name (or isn't in the local directory), adjust the SSH_KEY_FILE variable.
Similarly, if you want to use a different username, then adjust SSH_USER;
but be aware that ansible is present in the generated inventory file, so you would need to modify the inventory or (better yet) the mkinventory.tmpl file.

### Build mkinventory

```
go build mkinventory.go
```

This program reads the terraform.tfstate file and uses the mkinventory.tmpl file to transform the tfstate into inventory.yml.
You may tweak this template as needed to do cool stuff. The template is read at run-time, so you needn't recompile when you make changes to the template.

## Do Over and Over Again

### Use Terraform

```
terraform apply
```

### Generate your inventory file

```
./mkinventory
```

### Use Ansible

```
ansible-playbook -i inventory.yml site.yml
```

### Change stuff

Then run again....

## Give up and go home

```
terraform destroy
```
