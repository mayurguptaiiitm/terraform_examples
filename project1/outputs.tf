# output "public_ip" {
#   value = aws_instance.example.public_ip
#   description = "Public IP Address of the webserver"
# }

output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}