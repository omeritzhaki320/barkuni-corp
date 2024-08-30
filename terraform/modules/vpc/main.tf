resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = element(var.availability_zones, 0)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = element(var.availability_zones, 1)

  tags = {
    Name = "${var.name}-private-subnet"
  }
}

resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public.id
}

resource "aws_eip" "this" {
  vpc = true
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng.id
  }

  tags = {
    Name = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}