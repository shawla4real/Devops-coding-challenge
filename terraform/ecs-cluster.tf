#########################
# ECS Cluster
#########################
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

#########################
# Backend Task Definition & Service
#########################
resource "aws_ecs_task_definition" "backend" {
  family                   = "backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = "backend",
      image        = "${var.ecr_backend}:${var.build_number}",
      portMappings = [{
        containerPort = 8080,
        hostPort      = 8080,
        protocol      = "tcp"
      }],
      memory       = 512
    }
  ])
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [data.aws_subnet.public.id, data.aws_subnet.public2.id]
    security_groups = [aws_security_group.app.id]
    assign_public_ip = "true"
  }
  
  load_balancer {
    target_group_arn = aws_lb_target_group.backend_tg.arn
    container_name   = "backend"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.backend_listener]

}

#########################
# Frontend Task Definition & Service
#########################
resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = "frontend",
      image        = "${var.ecr_frontend}:${var.build_number}",
      portMappings = [{
        containerPort = 3000,
        hostPort      = 3000,
        protocol      = "tcp"
      }],
      # IMPORTANT: Pass the backend URL as an environment variable.
      environment = [
        {
          name  = "BACKEND_URL"
          value = "http://${aws_lb.backend_alb.dns_name}"
        }
      ],
      memory       = 512
    }
  ])
}

resource "aws_ecs_service" "frontend" {
  depends_on = [aws_ecs_service.backend]
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [data.aws_subnet.public.id, data.aws_subnet.public2.id]
    security_groups = [aws_security_group.app.id]
    assign_public_ip = "true"
  }
}
