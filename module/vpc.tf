resource "aws_vpc" "vpc_01"{
cidr_block = var.cidr_block

tags = {
    Name = "vpc-01"
}
}

resource "aws_subnet" "pub_sub" {
    vpc_id = aws_vpc.vpc_01.vpc_id
    cidr_block= var.pub_sub_block
    map_public_ip_on_launch= true
    tags = {
        Name = "pub-sub"
    }
}
resource "aws_subnet" "pri_sub" {
    vpc_id = aws_vpc.vpc_01.vpc_id
    cidr_block= var.pri_sub_block

    tags = {
        Name= "pri-sub"
    }
}
resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name = "igw-1"
  }
}
resource "aws_default_route_table" "MRT" {
  default_route_table_id = aws_vpc.vpc_01.default_route_table_id
  route{
  cidr_block= "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw_1.id 
  }
  tags = {
    Name = "mrt"
  }
}
