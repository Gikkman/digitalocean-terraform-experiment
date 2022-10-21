resource "digitalocean_ssh_key" "terraform_ssh" {
    name = "terraform-ssh-key"
    public_key = file("${var.do_ssh}.pub")
}