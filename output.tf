output "vpc_id" {
    value = aws_vpc.main.id
    description = "The id of the vpc"
  
}

output "vpc_arn" {
    value = aws_vpc.main.arn
    description = "The arn of the vpc"
  
}