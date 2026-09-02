output "instance_ips" {
    description = "The IPs of the EC2 instances"
    value = module.instances.public_ips
}