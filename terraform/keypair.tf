resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "generated" {
  key_name   = "generated-key2"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_openssh
  filename = "generated-key2.pem"
  file_permission = "0600"
}

#  set the environment variables AWS_ACCESS_KEY_ID, and AWS_SECRET_ACCESS_KEY with the values from the keys you just created.
#export AWS_ACCESS_KEY_ID="ACCESSKEYID"
# export AWS_SECRET_ACCESS_KEY="SECRET ACCESS KEY"
#ssh-keygen -t rsa -b 4096 -f MYKEY
