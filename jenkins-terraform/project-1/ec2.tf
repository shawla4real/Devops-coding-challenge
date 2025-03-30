resource "aws_instance" "jenkins" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins-ec2.id]
  key_name               = aws_key_pair.generated.key_name
  root_block_device {
    volume_size = 20
  }
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-jenkins-server" })
  )

}
# resource "aws_instance" "private" {
#   instance_type          = var.instance_type
#   ami                    = data.aws_ami.server_ami.id
#   subnet_id              = aws_subnet.private.id
#   vpc_security_group_ids = [aws_security_group.ec2.id]
#   key_name               = aws_key_pair.auth.id

#   # root_block_device {
#   #   volume_size = 10
#   # }
#   tags = merge(
#     local.common_tags,
#     tomap({ "Name" = "${local.prefix}-private-ec2" })
#   )

# }
# resource "aws_instance" "public" {
#   instance_type          = var.instance_type
#   ami                    = data.aws_ami.server_ami.id
#   subnet_id              = aws_subnet.public.id
#   vpc_security_group_ids = [aws_security_group.ec2.id]
#   key_name               = aws_key_pair.auth.id
#   # root_block_device {
#   #   volume_size = 10
#   # }
#   tags = merge(
#     local.common_tags,
#     tomap({ "Name" = "${local.prefix}-public-ec2" })
#   )

# }