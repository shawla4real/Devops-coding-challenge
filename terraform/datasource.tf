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
  id = "vpc-0b9e821d627b1bbd4"
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-public-subnet"]  # Must match your existing subnet's name tag
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]  # Reference to your VPC
  }

  filter {
    name   = "cidr-block"
    values = [var.subnet_cidr_list[0]]  # Matches your CIDR block
  }

  depends_on = [data.aws_vpc.vpc]  # Explicit dependency
}

data "aws_subnet" "public2" {
  filter {
    name   = "tag:Name"
    values = ["${local.prefix}-public2-subnet"]  # Must match your existing subnet's name tag
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]  # Reference to your VPC
  }

  filter {
    name   = "cidr-block"
    values = [var.subnet_cidr_list[2]]  #
  }

  depends_on = [data.aws_vpc.vpc]  
}

data "aws_ecr_repository" "frontend" {
  name = "frontend"
}

data "aws_iam_role" "jenkins" {
  name = "jenkins-role"
}

data "aws_security_group" "jenkins_ec2" {
  name = "Jenkins_sg"  

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]  
  }


}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-exec-role"
}