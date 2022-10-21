# Overview
This is a small example repo for setting up two servers (and initialize them), a loadbalancer, an SSH key (used for server initialization) and a subdomain record. All is done via terraform towards DigitalOcean

# Setup
You will need to sign up with a DigitalOcean account. Be aware that this example will incur costs on your DigitalOcean account (like maybe a dollar or two). **Remember to destroy resources when you are done to limit costs.**

## DigitalOcean Personal Access Token
Generate a new Personal Access Token (under the `API` tab on DigitalOcean). Suggest setting it to short lifetime, like 1 month or so. Save the token in a file somewhere, or in an environment variable. I store it in a file named `.pat` next to this file.

## SSH key
Generate a new SSH key, by running `ssh-keygen -C COMMENT_HERE`. Note the location of the generated key file. I stored it under `$HOME/.ssh/do_terraform`

## Domain record
This is currently setup to generate an A record for `terraform.gikkman.com`, under my pre-configured host `gikkman.com`. If you already got a domain to work with, with another host name, you'll have to edit the `digitalocean_domain` name in the `domain_record.tf` file. 

If you instead want to provision an entirely new domain, change the domain from `data` to `resource`, and change the way you reference the domain. To reference a `data` object, you have to start the reference with `data.`, so if you change to a resource, drop the `data.` prefix in the record reference.

# Commands
## Initialize
```
terraform init
```
This will initialize the provider (Digital Ocean), download the dependencies and create the `.tfstate` files

## Plan
```
terraform plan -var "do_pat=$(cat .pat)" -var "do_ssh=$HOME/.ssh/do_terraform"
```
This will show what terraform plans to do. 

If you don't include the `-var` args, terraform will prompt for the missing variables (and display their configured descriptions). Variables are declared in the `provider.tf` file.

## Apply
```
terraform apply -var "do_pat=$(cat .pat)" -var "do_ssh=$HOME/.ssh/do_terraform"
```
This will create (and import) all resources specified by terraform.

## Destroy
```
terraform destroy -var "do_pat=$(cat .pat)" -var "do_ssh=$HOME/.ssh/do_terraform"
```
This will destroy all resources currently **created** by terraform (so in my setup, since the domain is an imported data object, it will not be destroyed).

# File Structure
I've setup this repo with a `root module` and one `child module`. 

The root module will have to gather all variables that the child module needs, and then forward the variable to the child module. Additionally, the root module has to list all outputs that should be visible to the user (an output in a module is not shown). 

# Nice reads:
* Good guide: https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean
* Remote tfstate store on DigitalOcean: https://www.padok.fr/en/blog/digitalocean-kubernetes#kubernetes-cluster
* Module documentation: https://developer.hashicorp.com/terraform/language/modules
* Variable documentation: https://developer.hashicorp.com/terraform/language/values/variables