variable "region" {
  description = "AWS region"
  type = string
  default = "eu-west-3"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
  default = "quiz-eks"
}

variable "vpc_name" {
  description = "VPC Name for our EC2 server"
  type = string
  default = "EC2-vpc"
}

variable "igw_name" {
  description = "Internet Gate Way Name for our EC2 server"
  type = string
  default = "EC2-igw"
}

variable "subnet_name" {
  description = "Subnet Name for our EC2 server"
  type = string
  default = "EC2-subnet"
}

variable "rt_name" {
  description = "Route Table Name for our EC2 server"
  type = string
  default = "EC2-rt"
}

variable "sg_name" {
  description = "Security Group for our EC2 server"
  type = string
  default = "EC2-sg"
}


variable "iam_role" {
  description = "IAM Role for the EC2 Server"
  type = string
  default = "EC2-iam_role"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-00c71bd4d220aa22a" 
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.large"
}

variable "key_name" {
  description = "EC2 keypair"
  type        = string
  default     = "aws_ec2_terraform"
}

variable "instance_name" {
  description = "EC2 name for EC2-server"
  type        = string
  default     = "EC2-server"
}

variable "security_group_id" {
  description = "Security Group ID for EC2-server"
  type        = string
  default     = "ec2-sg"
}

variable "subnet_id" {
  description = "Subnet ID for EC2-server"
  type        = string
  default     = "ec2_public_subnet"
}