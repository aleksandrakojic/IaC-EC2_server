output "region" {
    description = "EC2 Server region"
    value = var.region
}
output "ec2_public_ip" {
  description = "Public IP address of the EC2 server"
  value       = aws_instance.ec2.public_ip
}