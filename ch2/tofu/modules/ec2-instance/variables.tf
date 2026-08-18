variable "name" {
  description = "The name for the EC2 instance and all resources"
  type        = string
  default     = "sample-app-tofu"
}

variable "instance_type" {
  type = string
}

variable "ami_name" {
  description = "Name of the AMI for EC2 instance"
  type = string
  default = "sample-app-packer-*"
}
