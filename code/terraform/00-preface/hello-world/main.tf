terraform {
    required_version = ">=0.12, < 0.13"
}

provider "null" {
    version = "2.1.2"
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
        source = "setup/docker-override.conf"
        destination = "/tmp/docker-override.conf"
    }

    provisioner "file" {
        source = "setup/get-docker.sh"
        destination = "/tmp/get-docker.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo mkdir -p /etc/systemd/system/docker.service.d",
            "sudo mv -f /tmp/docker-override.conf /etc/systemd/system/docker.service.d/override.conf",
            "chmod a+x /tmp/get-docker.sh",
            "sh /tmp/get-docker.sh",
            "sudo usermod -aG docker ${var.ssh_user}",
        ]
    }

    provisioner "remote-exec" {
	when  = "destroy"
        inline = [
            "rm -rf /tmp/get-docker.sh",
            "sudo apt-get remove -y -qq docker-ce-cli",
            "sudo apt-get remove -y -qq docker-ce",
            "sudo rm -f /etc/systemd/system/docker.service.d",
            "sudo gpasswd -d ${var.ssh_user} docker"
        ]
    }
} 
