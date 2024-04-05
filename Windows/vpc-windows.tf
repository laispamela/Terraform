# VPC
resource "aws_vpc" "VPC-ANEIS" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "VPC-ANEIS"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "IGW-ANEIS" {
  vpc_id = aws_vpc.VPC-ANEIS.id

  tags = {
    Name = "IGW-ANEIS"
  }
}

# SUBNET Subrede-Pub1
resource "aws_subnet" "Subrede-Pub1" {
  vpc_id                  = aws_vpc.VPC-ANEIS.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Subrede-Pub1"
  }
}
# SUBNET Subrede-Pub2
resource "aws_subnet" "Subrede-Pub" {
  vpc_id                  = aws_vpc.VPC-ANEIS.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Subrede-Pub2"
  }
}

# SUBNET Subrede-Pri1
resource "aws_subnet" "Subrede-Pri1" {
  vpc_id            = aws_vpc.VPC-ANEIS.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subrede-Pri1"
  }
}
# SUBNET Subrede-Pri2
resource "aws_subnet" "Subrede-Pri2" {
  vpc_id            = aws_vpc.VPC-ANEIS.id
  cidr_block        = "192.168.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subrede-Pri2"
  }
}



# ROUTE TABLE Publica
resource "aws_route_table" "Rotas-ANEIS-Pub" {
  vpc_id = aws_vpc.VPC-ANEIS.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-ANEIS.id
  }

  tags = {
    Name = "Rotas-ANEIS-Pub"
  }
}

# ROUTE TABLE Privada
resource "aws_route_table" "Rotas-ANEIS-Pri" {
  vpc_id = aws_vpc.VPC-ANEIS.id

  tags = {
    Name = "Rotas-ANEIS-Pri"
  }
}

# SUBNET ASSOCIATION Pub
resource "aws_route_table_association" "Subrede-Pub" {
  subnet_id      = aws_subnet.Subrede-Pub1.id
  route_table_id = aws_route_table.Rotas-ANEIS-Pub.id
}