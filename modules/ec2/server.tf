resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  force_destroy = var.force_destroy
  iam_instance_profile = var.iam_instance_profile
  key_name     = var.key_name
  security_groups = [aws_security_group.this.name]
  subnet_id    = var.subnet_id
  user_data   = var.user_data
  depends_on = [aws_security_group.this]
  tags = {
    Name = var.instance_name
  }

  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }

  # Root block device
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    delete_on_termination = var.delete_on_termination
    encrypted = var.encrypted
  }
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key
}

