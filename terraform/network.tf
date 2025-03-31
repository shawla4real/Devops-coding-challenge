

resource "aws_lb" "frontend" {
  name                       = "frontend-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = toset(["data.aws_subnet.public, data.aws_subnet.public2, "])
  enable_deletion_protection = true

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-frontend-lb" })
  )
}
resource "aws_lb_target_group" "frontend" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = "data.aws_vpc.vpc"
  name     = "frontend-lb-tg"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-frontend-lb" })
  )
}