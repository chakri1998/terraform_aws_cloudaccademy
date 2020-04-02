provider "aws" {
  version = "< 2"

  region  = "us-west-2" # Oregon
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "192.168.100.0/24"
  enable_dns_hostnames = true

  tags {
    Name = "Web VPC"
  }
}

resource "aws_subnet" "web_subnet_1" {
  vpc_id            = "${aws_vpc.web_vpc.id}"
  cidr_block        = "192.168.100.0/25"
  availability_zone = "us-west-2a"

  tags {
    Name = "Web Subnet 1"
  }
}

resource "aws_subnet" "web_subnet_2" {
  vpc_id            = "${aws_vpc.web_vpc.id}"
  cidr_block        = "192.168.100.128/25"
  availability_zone = "us-west-2b"

  tags {
    Name = "Web Subnet 2"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0fb83677"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.web_subnet_1.id}"
  
  tags {
    Name = "Web Server 1"
  }
}

