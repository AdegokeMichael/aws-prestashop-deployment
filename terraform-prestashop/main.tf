resource "aws_instance" "prestashop_vm" {
	ami = var.ami_id
	instance_type = var.instance_type
	key_name = var.key_name
	associate_public_ip_address = true

	tags = {
	   Name = "Prestashop-VM"
	}
	provisioner "remote-exec" {
	    inline = [
	       "sudo apt update -y"
	    ]

	    connection {
	        type = "ssh"
	        user = "ubuntu"
	        private_key = file(var.private_key_path)
	        host = self.public_ip
	    }
	}
}

resource "aws_eip" "elastic_ip" {
	instance = aws_instance.prestashop_vm.id
}

