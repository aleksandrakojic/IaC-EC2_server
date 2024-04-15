resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2-instance_profile"
  role = aws_iam_role.iam_role.name
}