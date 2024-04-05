### GRUPO DE SEGURANÇA ####
resource "aws_security_group" "Grupo-Sec-debian" {
  name        = "Grupo-Sec-Debian"
  description = "Libera SSH e HTTP."
  vpc_id      = aws_vpc.VPC-CloudPlay.id

  #Liberar porta SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar porta HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar porta PING
  ingress {
    protocol    = "icmp"
    from_port   = 8
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### GRUPO EC2 ####

data "template_file" "user_data" {
   template = file("./scripts/scripts_debian.sh")
}

resource "aws_instance" "debian" {
  ami                         = "ami-058bd2d568351da34" #Padrão da imagem vinda da AWS
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-071f24536d2e7d232"
  key_name                    = "debian"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.Grupo-Sec-debian.id]
  user_data                   = base64encode(data.template_file.user_data.rendered)

  tags = {
    Name = "Debian-Site"
  }
}

output "instance_public_ip" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.debian.public_ip
}

