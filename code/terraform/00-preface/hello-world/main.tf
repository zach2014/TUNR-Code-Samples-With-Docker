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

    provisioner "file" {
        source = "setup/get-docker.sh"
        destination = "/tmp/get-docker.sh"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod a+x /tmp/get-docker.sh",
            "sh /tmp/get-docker.sh"
        ]
    }

    provisioner "remote-exec" {
	when  = "destroy"
        inline = [
            "rm -rf /tmp/get-docker.sh",
            "sudo -E sh -c apt-get remove -y -qq docker-ce-cli",
            "sudo -E sh -c apt-get remove -y -qq docker-ce",
        ]
    }
} 
