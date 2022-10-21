resource "digitalocean_droplet" "www-2" {
    image = "ubuntu-22-04-x64"
    name = "www-2"
    region = "ams3"
    size = "s-1vcpu-512mb-10gb"
    monitoring = true
    ssh_keys = [digitalocean_ssh_key.terraform_ssh.id]

    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.do_ssh)
        timeout = "2m"
    }

    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            # install nginx
            "sudo apt update -y",
            "sudo apt install -y nginx",
            "echo \"Hello from www-2\" > /var/www/html/index.nginx-debian.html"
        ]
    }
}

