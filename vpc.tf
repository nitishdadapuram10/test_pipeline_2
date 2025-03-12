resource "aws_vpc" "p2_vpc" {
  cidr_block       = "10.0.0.0/16"
 
  enable_dns_hostnames = true

  tags = {
    Name = "p2_vpc"
  }
}

resource "aws_subnet" "p2_public_subnet" {
  vpc_id     = aws_vpc.p2_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "p2_public_subnet"
  }
}

resource "aws_subnet" "p2_public_subnet_2" {
  vpc_id     = aws_vpc.p2_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "p2_public_subnet_2"
  }
}


resource "aws_subnet" "p2_private_subnet" {
  vpc_id     = aws_vpc.p2_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "p2_private_subnet"
  }
}


resource "aws_internet_gateway" "p2_internet_gateway" {
  vpc_id = aws_vpc.p2_vpc.id
}

resource "aws_route_table" "p2_public_route_table" {
  vpc_id = aws_vpc.p2_vpc.id
}

resource "aws_route" "p2-public_internet_route" {
  route_table_id         = aws_route_table.p2_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.p2_internet_gateway.id
}

resource "aws_route_table_association" "p2_public_association" {	
  subnet_id      = aws_subnet.p2_public_subnet.id
  route_table_id = aws_route_table.p2_public_route_table.id
}

resource "aws_route_table_association" "p2_public_association_2" {
  subnet_id      = aws_subnet.p2_public_subnet_2.id
  route_table_id = aws_route_table.p2_public_route_table.id
}











