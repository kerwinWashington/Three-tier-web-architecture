resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Team1"
  }
}

resource "aws_subnet" "public" {
  count = var.publicSubnetCount
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = var.AZ[count.index]
  tags = {
    Name = "Team1-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = var.privateSubnetCount
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.publicSubnetCount)
  availability_zone = var.AZ[count.index]
  tags = {
    Name = "Team1-private-${count.index}"
  }
}

resource "aws_subnet" "db_subnet" {
  count = var.publicSubnetCount
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.publicSubnetCount + var.privateSubnetCount)
  availability_zone = var.AZ[count.index]
  tags = {
    Name = "Team1-db-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Team1-igw"
  }
}

resource "aws_nat_gateway" "natgw1" {
  allocation_id = aws_eip.nat-eip[0].id
  subnet_id = aws_subnet.public[0].id
  tags = {
    Name = "nat-Team1"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "natgw2" {
  allocation_id = aws_eip.nat-eip[1].id
  subnet_id = aws_subnet.public[1].id
  tags = {
    Name = "nat-2-Team1"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat-eip" {
  domain   = "vpc"
  count = var.Nat_Count
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Team1-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  # count = var.privateSubnetCount
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw1.id
  }
  tags = {
    Name = "Team1-priv-rt"
  }
}

resource "aws_route_table" "private-2" {
  vpc_id = aws_vpc.main.id
  # count = var.privateSubnetCount
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw2.id
  }
  tags = {
    Name = "Team1-priv-rt2"
  }
}

resource "aws_route_table_association" "public-rt" {
  count = var.publicSubnetCount
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-rt" {
  subnet_id = aws_subnet.private[0].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-rt-2" {
  subnet_id = aws_subnet.private[1].id
  route_table_id = aws_route_table.private-2.id
}

resource "aws_route_table" "db_subnet_1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw1.id
  }
  tags = {
    Name = "Team1-db-subnet-rt"
  }
}

resource "aws_route_table" "db_subnet_2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw2.id
  }
  tags = {
    Name = "Team1-db-subnet-rt2"
  }
}

resource "aws_route_table_association" "db_subnet-rt" {
  subnet_id = aws_subnet.db_subnet[0].id
  route_table_id = aws_route_table.db_subnet_1.id
}

resource "aws_route_table_association" "db_subnet-rt-2" {
  subnet_id = aws_subnet.db_subnet[1].id
  route_table_id = aws_route_table.db_subnet_2.id
}

resource "aws_db_subnet_group" "default" {
  name  = "aurorasubnetgroupteamone"
  # count = var.privateSubnetCount
  #   vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.db_subnet[0].id, aws_subnet.db_subnet[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}