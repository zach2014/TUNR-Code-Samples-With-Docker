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
    
    connection {
    type = "ssh"
    user = var.ssh_user
    password = var.ssh_password
    host = var.ssh_target_host
    }

    provisioner "remote-exec" {
        inline = [ 
        "touch /tmp/terraform-bootstrap-provision.txt"   
        ]
    }

    provisioner "remote-exec" {
	when  = "destroy"
        inline = [ 
        "rm -rf /tmp/terraform-bootstrap-provision.txt"   
        ]
    }
} 
