# output.tf
output "ec2_public_ip" {
  description = "public ip for ec2"
  value       = aws_instance.jenkins.public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}


output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.jenkins.id
}