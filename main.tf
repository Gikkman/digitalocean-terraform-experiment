terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
    token = var.do_pat
}

module "do" {
  source = "./modules/terraform-digitalocean-example"

  # Forward variable to module
  do_ssh = var.do_ssh
}