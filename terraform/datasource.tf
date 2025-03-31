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
  filter {
    name   = "vpc-id"
    values = ["vpc-0b9e821d627b1bbd4"]
  }

  filter {
    name   = "tag:Name"
    values = ["my-vpc"] # Add your VPC name tag
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "subnet-id"
    values = ["subnet-04565c45ab6bae2ed"]
  }

  filter {
    name   = "tag:Name"
    values = ["public-subnet-1a"] # Add your subnet name tag
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "public2" {
  filter {
    name   = "subnet-id"
    values = ["subnet-0d64f1acd80c73f03"]
  }

  filter {
    name   = "tag:Name"
    values = ["public-subnet-1b"] 
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_ecr_repository" "frontend" {
  name = "frontend"
}

data "aws_iam_role" "jenkins" {
  name = "jenkins-role"
}

data "aws_security_group" "app-sg" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]  
  }

  filter {
    name   = "jenkins-sg"
    values = ["app-sg"]  
  }
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"
}