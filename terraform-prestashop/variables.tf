variable "region" {
  description = "The AWS region where resources will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to attach the Security Group"
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "private_key_path" {
  description = "path to your public key path"
  type        = string
}
