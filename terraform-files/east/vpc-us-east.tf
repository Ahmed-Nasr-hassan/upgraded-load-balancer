provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files = ["~/.aws/config"]
  region = "us-east-1"
}

resource "aws_vpc" "nasr-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        "name" : "terraform-vpc"
    }

}

resource "aws_subnet" "nasr-subnet" {
    vpc_id = aws_vpc.nasr-vpc.id
    cidr_block = "10.0.0.0/24"
}

resource "aws_internet_gateway" "nasr-gateway" {
    vpc_id = aws_vpc.nasr-vpc.id
}

resource "aws_route_table" "nasr-route-table" {
    vpc_id = aws_vpc.nasr-vpc.id
    
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nasr-gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.nasr-gateway.id
  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.nasr-subnet.id
  route_table_id = aws_route_table.nasr-route-table.id
}