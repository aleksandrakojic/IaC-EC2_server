
resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.ec2_sg.name]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.public_subnet.id
  
  iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 30
  }
  user_data = templatefile("./install-tools.sh", {})

  tags = {
    Name = var.instance_name
  }
}