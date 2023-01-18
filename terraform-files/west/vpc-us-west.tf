provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files = ["~/.aws/config"]
  region = "us-west-2"
}


resource "aws_vpc" "nasr-vpc-w" {
    cidr_block = "20.0.0.0/16"
    tags = {
        "name" : "terraform-vpc"
    }

}

resource "aws_subnet" "nasr-subnet-w" {
    vpc_id = aws_vpc.nasr-vpc-w.id
    cidr_block = "20.0.0.0/24"
}

resource "aws_internet_gateway" "nasr-gateway-w" {
    vpc_id = aws_vpc.nasr-vpc-w.id
}

resource "aws_route_table" "nasr-route-table-w" {
    vpc_id = aws_vpc.nasr-vpc-w.id
    
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nasr-gateway-w.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.nasr-gateway-w.id
  }

}

resource "aws_route_table_association" "rt-association-w" {
  subnet_id      = aws_subnet.nasr-subnet-w.id
  route_table_id = aws_route_table.nasr-route-table-w.id
}