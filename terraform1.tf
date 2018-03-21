provider "aws" {
  access_key = "AKIAJNIZ7CMK5ID2HL3Q"
  secret_key = "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"
  region = "us-east-1"
}

resource "aws_vpc" "terraform" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "terraform"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.terraform.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "subnet1"
  }
}

resource "aws_instance" "ec2" {
  ami = "ami-005dba69"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet1.id}"
}

resource "aws_eip" "elasticip" {
  instance = "${aws_instance.ec2.id}"
}

