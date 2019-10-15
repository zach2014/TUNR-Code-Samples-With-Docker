terraform {
    required_version = ">=0.12, < 0.13"
}


variable "ssh_user" {
    type = string
}


variable "ssh_password" {
    type = string
}


variable "ssh_target_host" {
    type = string
}

resource "null_resource" "target_host" {
    
    provisioner "remote-exec" {
        inline = [ 
        "pwd"   
        ]

        connection {
        type = "ssh"
        user = var.ssh_user
        password = var.ssh_password
        host = var.ssh_target_host
        }
    }

} 
