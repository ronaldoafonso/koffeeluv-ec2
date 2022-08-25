
variable "environment" {
  description = "Project environment"
  type        = string
}

variable "instances" {
  description = "EC2 Instances"
  type        = map
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Subnets"
  type        = map
}

variable "security_groups" {
  description = "Secutiry groups"
  type        = map
}

variable "key_pairs" {
  description = "Key pairs"
  type        = map
}
