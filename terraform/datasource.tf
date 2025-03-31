data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "vpc" {
  id = "vpc-0b9e821d627b1bbd4" # Replace with your VPC ID
}

data "aws_subnet" "public.id" {
  id = "subnet-04565c45ab6bae2ed" # Replace with your subnet ID
}

data "aws_subnet" "public2.id" {
  id = "subnet-0c3ad68030e90a2f2" # Replace with your subnet ID
}
data "aws_ecr_repository" "frontend" {
  name = "frontend"
}
   