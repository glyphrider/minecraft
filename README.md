# Minecraft Server (AWS)

1. Install and configure [Terraform](https://terraform.io)
1. Install and configure [Ansible](https://www.ansible.com) -- something like `pip3 install --user ansible`
1. Install and configure [NodeJS](https://nodejs.org) and [Yarn](https://yarnpkg.com).
1. Download the server.jar from [Minecraft](https://www.minecraft.net/en-us/download/server) and place it in this directory
1. Setup your AWS environment
```
export AWS_ACCESS_KEY_ID=somevalue
export AWS_SECRET_ACCESS_KEY=somesecretvalue
```
1. Create a deployment bucket (if you don't already have one) for serverless, `aws s3 mb s3://someuniquename` and export the name into your environment as **SLS_DEPLOYMENT_BUCKET** (make sure this is done, even if the bucket already existed).
1. Move into the serverless directory and have yarn setup and deploy the project
```
cd serverless
yarn
yarn test
yarn deploy -s prod
cd ..
```
1. Save the endpoints in environment variables **SLS_WHITELIST_ENDPOINT** and **SLS_OPS_ENDPOINT**.
1. Use ansible-galaxy to pull the requirements, `ansible-galaxy install -r requirements.yml`.
1. Create a new deployment key via `ssh-keygen -f ansible -C 'Ansible Minecraft Automation' -P ''`. Optionally add this to a running ssh-agent `ssh-add ansible`.
1. Create a reasonable operators.json file, which is an array of strings (Minecraft profile names), for the ops list.
1. Create a reasonable users.json file, which is an array of strings (Minecraft profile names), for the whitelist.
1. Create a valid cloudinit.yml using ansible `ansible-playbook generate-cloudinit.yml -e 'ssh_user=ansible ssh_key_file=ansible.pub'`
1. Run `terraform init` to acquire needed plugins and providers.
1. Run `terraform apply` to create the infrastructure.
1. Run `ansible-playbook minecraft.yml` to provision the minecraft server.
1. Use `terraform output` to acquire the public IP address of the server.
1. Connect with your Minecraft client
