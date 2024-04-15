output "cluster_name" {
    description = "AWS EKS Cluster Name"
    value = module.eks.cluster_name
}

output "cluster_endpoint" {
    description = "Endpoint for AWS EKS"
    value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
    description = "Security group ID for AWS EKS Cluster"
    value = module.eks.cluster_security_group_id
}

output "region" {
    description = "EC2 Server region"
    value = var.region
}
output "ec2_public_ip" {
  description = "Public IP address of the EC2 server"
  value       = aws_instance.ec2.public_ip
}