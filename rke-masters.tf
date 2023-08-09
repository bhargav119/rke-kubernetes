resource "aws_instance" "master01" {
  ami                         = var.imagename
  availability_zone           = "us-east-1a"
  instance_type               = "t2.medium"
  key_name                    = "LaptopKey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "rke-master-01"
  }
  user_data = <<-EOF
		#!/bin/bash
        curl https://get.docker.com | sudo bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
	EOF
  root_block_device {
    # iops        = 100 #Only allow if you used gp2 or io1 or io2 
    volume_size = 12
    volume_type = "gp2"
  }
}

resource "aws_instance" "master02" {
  ami                         = var.imagename
  availability_zone           = "us-east-1b"
  instance_type               = "t2.medium"
  key_name                    = "LaptopKey"
  subnet_id                   = aws_subnet.subnet2-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "rke-master-02"
  }
  user_data = <<-EOF
		#!/bin/bash
        curl https://get.docker.com | sudo bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
	EOF
  root_block_device {
    # iops        = 100 #Only allow if you used gp2 or io1 or io2 
    volume_size = 12
    volume_type = "gp2"
  }
}

resource "aws_instance" "master03" {
  ami                         = var.imagename
  availability_zone           = "us-east-1c"
  instance_type               = "t2.medium"
  key_name                    = "LaptopKey"
  subnet_id                   = aws_subnet.subnet3-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "rke-master-03"
  }
  user_data = <<-EOF
		#!/bin/bash
        curl https://get.docker.com | sudo bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
	EOF
  root_block_device {
    # iops        = 100 #Only allow if you used gp2 or io1 or io2 
    volume_size = 12
    volume_type = "gp2"
  }
}

