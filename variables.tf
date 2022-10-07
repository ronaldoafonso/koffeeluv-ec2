
variable "environment" {
  description = "Project environment"
  type        = string
}

variable "instances" {
  description = "EC2 Instances"
  type        = map
}

variable "subnets" {
  description = "Subnets"
  type        = map
}

variable "security_groups" {
  description = "Secutiry groups"
  type        = map
}

variable "lb" {
  description = "Load Balancer"
  type        = any
}
