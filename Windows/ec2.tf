### GRUPO DE SEGURANÇA ####
resource "aws_security_group" "Grupo-Sec-windows" {
  name        = "Grupo-Sec-windows"
  description = "Libera RDP e HTTP, HTTPS."
  vpc_id      = aws_vpc.VPC-ANEIS.id

  #Liberar porta RDP (Windows Remote Desktop)
ingress {
  from_port   = 3389
  to_port     = 3389
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

#Liberar porta HTTPS
ingress {
  from_port   = 443
  to_port     = 443
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
   template = file("./scripts/script.ps1")
}

  resource "aws_instance" "windows" {
  ami           = "ami-03cd80cfebcbb4481"
  instance_type = "t2.medium"
  key_name      = "aneis"
  vpc_security_group_ids      = [aws_security_group.Grupo-Sec-windows.id]
  subnet_id              = aws_subnet.Subrede-Pub1.id


  tags = {
    Name = "windows"
  }
}


output "instance_public_ip" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.windows.public_ip
}