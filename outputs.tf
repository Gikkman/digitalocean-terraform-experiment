output "www-1_ip" {
  description = "The IP of the first droplet"
  value = module.do.digitalocean_droplet.www-1.ipv4_address
}

output "www-2_ip" {
  description = "The IP of the second droplet"
  value = module.do.digitalocean_droplet.www-2.ipv4_address
}

output "www-lb_ip" {
  description = "The IP of the loadbalancer"
  value = module.do.digitalocean_loadbalancer.www-lb.ip
}