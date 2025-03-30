# resource "aws_ssm_parameter" "backend_url" {
#   name  = "/app/backend/url"
#   type  = "String"
#   value = "http://backend.internal:3000"
# }