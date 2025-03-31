resource "aws_ecs_cluster" "cluster" {
  name = "Devops-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-ecs-cluster" })
  )
}
resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # Required for Fargate
  memory                   = "512" # Required for Fargate (or use memoryReservation)
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([{
    name         = "frontend",
    image = "${var.ecr_frontend}:${var.build_number}",

    portMappings = [{ containerPort = 8080}],

    memory = 512, # Hard limit (MiB)

  }])
}
resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.frontend.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [data.aws_subnet.public.id, data.aws_subnet.public2.id]

  }
}
resource "aws_ecs_task_definition" "backend" {
  family                   = "backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # Required for Fargate
  memory                   = "512" # Required for Fargate (or use memoryReservation)
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([{
    name         = "backend",
    image = "${var.ecr_backend}:${var.build_number}"

    portMappings = [{ containerPort = 3000 }],

    memory = 512, # Hard limit (MiB)

  }])
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [data.aws_subnet.public.id, data.aws_subnet.public2.id]

  }
}