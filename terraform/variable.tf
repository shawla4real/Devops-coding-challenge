
variable "region" {
  description = "Value of the region"
  type        = string
  default     = "us-east-1"

}
# variable "action" {
#   type        = string
#   description = "Action to perform on EC2 instances (start/stop)"
# }
variable "prefix" {
  default     = "lf-challenge"
  description = ""
}
variable "environment" {
  default = "dev"
}
variable "contact" {
  default = "solafolorunsho1@gmail.com"

}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}
variable "subnet_cidr_list" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

}
variable "instance_type" {
  default = "t2.medium"
}
variable "ecr_backend" {
  description = "ECR repository URL for the backend container"
  type        = string
  default     = "662508601281.dkr.ecr.us-east-1.amazonaws.com/backend"
}

variable "ecr_frontend" {
  description = "ECR repository URL for the backend container"
  type        = string
  default     = "662508601281.dkr.ecr.us-east-1.amazonaws.com/frontend"
}
variable "build_number" {
  description = "Build number tag for the container image"
  type        = string
}

# variable "backend_endpoint" {
#   description = "The URL endpoint for the backend service that the frontend should connect to."
#   type        = string
# }
