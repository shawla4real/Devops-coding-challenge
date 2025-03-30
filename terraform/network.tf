

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