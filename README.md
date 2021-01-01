# Minecraft Server

1. Install and configure [Terraform](https://terraform.io)
1. Install and configure [Ansible](https://www.ansible.com) -- something like `pip3 install --user ansible`
1. Install and configure [NodeJS](https://nodejs.org) and [Yarn](https://yarnpkg.com).
1. Download the server.jar from [Minecraft](https://www.minecraft.net/en-us/download/server) and place it in this directory
1. (Optionally, ) move into the serverless directory and have yarn setup and deploy the project
```
cd serverless
yarn
yarn test
yarn deploy -s $(whoami)
cd -
```
1. Save the endpoints in environment variables **SLS_WHITELIST_ENDPOINT** and **SLS_OPS_ENDPOINT**; there are defaults that point to my production deployment.
1. Create a new deployment key via `ssh-keygen -f ansible -C 'Ansible Minecraft Automation' -P ''`. Optionally (*but highly recommended*), add this to a running ssh-agent `ssh-add ansible`.
1. Create a reasonable operators.json file, which is an array of strings (Minecraft profile names), for the ops list.
1. Create a reasonable users.json file, which is an array of strings (Minecraft profile names), for the whitelist.
1. Create a valid cloudinit.yml using ansible `ansible-playbook generate-cloudinit.yml -e 'ssh_user=ansible ssh_key_file=ansible.pub'`
1. Choose your desired provider ([aws](aws/README.md), [libvirt](libvirt/README.md), [vagrant](vagrant/README.md) and change into that directory.
