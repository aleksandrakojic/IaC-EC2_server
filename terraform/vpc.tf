resource "aws_vpc" "vpc" {
  enable_dns_hostnames = true
  enable_dns_support   = true

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc]

  tags = {
    Name = var.igw_name
  }
}

resource "aws_subnet" "public_subnet" {
  depends_on = [aws_internet_gateway.igw]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_security_group" "ec2_sg" {
  vpc_id      = aws_vpc.vpc.id
  description = "Allowing HTTP, SSH Access"

  ingress = [
    for port in [22, 8080, 9000, 9090, 80] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      security_groups  = []
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}