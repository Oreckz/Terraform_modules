#Create a new VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = "${var.cidr_block}"
  enable_dns_support = true
  enable_dns_hostnames = true
}

#Create an internet gateway for the VPC
resource "aws_internet_gateway" "tf_ig" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  
  tags {
    Name = "Terraform VPC"
  }
}

#Create a route table for the VPC
resource "aws_route_table" "tf_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  
  tags {
    Name = "Terraform Routing Table"
  }
}

#Create a subnet for our instances
resource "aws_subnet" "tf_sn" {
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.cidr_block}"
  map_public_ip_on_launch = true
  
  tags {
    Name = "Terraform Subnet"
  }
}

#Create association between route table and subnet
resource "aws_route_table_association" "tf_assoc" {
  subnet_id      = "${aws_subnet.tf_sn.id}"
  route_table_id = "${aws_route_table.tf_rt.id}"
}

#Add rules to allow the VPC internet access
resource "aws_route" "internet_route" {
  route_table_id         = "${aws_route_table.tf_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.tf_ig.id}"
}