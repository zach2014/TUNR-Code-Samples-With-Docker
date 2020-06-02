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
            "sudo chmod a+x /tmp/get-docker.sh",
            "sh /tmp/get-docker.sh",
            "sudo usermod -aG docker ${var.ssh_user}",
            "sudo systemctl daemon-reload",
            "sudo systemctl restart docker.service"
        ]
    }

    provisioner "remote-exec" {
	when  = destroy
        inline = [
            "rm -rf /tmp/get-docker.sh",
            "sudo systemctl stop docker.service",
            "sudo apt-get remove -y -qq docker-ce-cli 2> /dev/null",
            "sudo apt-get remove -y -qq docker-ce 2> /dev/null",
            "sudo rm -rf /etc/systemd/system/docker.service.d",
            "sudo gpasswd -d ${var.ssh_user} docker"
        ]
    }
}

provider "docker" {
    version = "2.5.0"
    host = "tcp://${var.ssh_target_host}:2376"
}

resource "docker_container" "hello-world" {
    image = "${docker_image.hello-world.latest}"
    name = "hello-world-with-terraform"
    must_run = "false"
    restart = "on-failure"
}

resource "docker_image" "hello-world" {
    name = "hello-world:latest"
}
