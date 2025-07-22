provider "aws" {
  region = var.region
}

resource "aws_security_group" "prestashop_sg" {
  name        = "prestashop-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prestashop_vm" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.prestashop_sg.id]

  tags = {
    Name = "Prestashop-VM"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.prestashop_vm.id
}
