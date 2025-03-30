resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-vpc" })

  )
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_list[0] #10.0.1.0/24 ->form ["10.0.1.0/24", "10.0.2.0/24"]
  map_public_ip_on_launch = true                    #only for public subnet
  availability_zone       = "${var.region}a"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-subnet" })

  )
}
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_list[2] #10.0.1.0/24 ->form ["10.0.1.0/24", "10.0.2.0/24"]
  map_public_ip_on_launch = true                    #only for public subnet
  availability_zone       = "${var.region}b"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public2-subnet" })

  )
}
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_list[1] ##10.0.2.0/24 ->form ["10.0.1.0/24", "10.0.2.0/24"]
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"


  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-private-subnet" })

  )
}

# Internet gateway to enable traffic from internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main-igw" })

  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-rtb" })
  )
}
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_lb" "frontend" {
  name                       = "frontend-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = toset([aws_subnet.public.id, aws_subnet.public2.id, ])
  enable_deletion_protection = true

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-frontend-lb" })
  )
}
resource "aws_lb_target_group" "frontend" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  name     = "frontend-lb-tg"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-frontend-lb" })
  )
}