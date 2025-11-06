# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
       Name = "${var.project}-vpc"
    }
}
  
# Create Public Subnet 1
  resource "aws_subnet" "public_subnet_1" {
  vpc_id    = aws_vpc.main.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "${var.project}-public-subnet-1"
  }
}

# Create Public Subnet 2
  resource "aws_subnet" "public_subnet_2" {
  vpc_id    = aws_vpc.main.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "eu-west-1b"
  
  tags = {
    Name = "${var.project}-public-subnet-2"
  }
}

# Create Public Subnet 3
  resource "aws_subnet" "public_subnet_3" {
  vpc_id    = aws_vpc.main.id
  cidr_block = "10.0.32.0/20"
  availability_zone = "eu-west-1c"
  
  tags = {
    Name = "${var.project}-public-subnet-3"
  }
}



# Create a Internet Gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-igw"
  }
}

# create public route table 
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

 

  tags = {
    Name = "${var.project}-public-rt"
  }
}
resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.main.id

}

resource "aws_route_table_association" "public_subnet_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.main.id
}

# Create Private Subnet 1
  resource "aws_subnet" "private_subnet_1" {
  vpc_id    = aws_vpc.main.id
  cidr_block = "10.0.128.0/20"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "${var.project}-private-subnet-1"
  }
}

# Create Private Subnet 2
  resource "aws_subnet" "private_subnet_2" {
  vpc_id    = aws_vpc.main.id
  cidr_block = "10.0.144.0/20"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "${var.project}-private-subnet-2"
  }
}

# Create Private Subnet 3
  resource "aws_subnet" "private_subnet_3" {
  vpc_id    = aws_vpc.main.id
  cidr_block = "10.0.160.0/20"
  availability_zone = "eu-west-1c"

  tags = {
    Name = "${var.project}-private-subnet-3"
  }
}

# create EIP = Elastic IP for NAT
resource "aws_eip" "NAT" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-NAT-EIP"
  }
  depends_on = [aws_internet_gateway.gw]
}

# create NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.project}-NAT-gateway"
  }
    

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

# create private route table 1
resource "aws_route_table" "private_subnet_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

 

  tags = {
    Name = "${var.project}-private-subnet-1"
  }
}
resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_subnet_1.id
}

# create private route table 2
resource "aws_route_table" "private_subnet_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

 

  tags = {
    Name = "${var.project}-private-subnet-2"
  }
}
resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_subnet_2.id
}


# create private route table 3
resource "aws_route_table" "private_subnet_3" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

 

  tags = {
    Name = "${var.project}-private-subnet-3"
  }
}
resource "aws_route_table_association" "private_subnet_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_subnet_3.id
}





