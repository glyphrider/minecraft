# Minecraft Server (AWS)

1. Setup your AWS environment
```
export AWS_ACCESS_KEY_ID=somevalue
export AWS_SECRET_ACCESS_KEY=somesecretvalue
```
1. Use ansible-galaxy to pull the requirements, `ansible-galaxy install -r requirements.yml`.
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
