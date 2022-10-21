data "digitalocean_domain" "domain" {
  name = "gikkman.com"
}


resource "digitalocean_record" "www" {
  domain = data.digitalocean_domain.domain.id
  type = "A"
  name = "terraform"
  value = digitalocean_loadbalancer.www-lb.ip
}