
#variable for vpc cider range
   variable "vpc_cidr" {
   type = string
   default = "10.0.0.0/16"

   
}
# give project a name
   variable "project" {
    type =  string
    default = "apache"
}

# specify launch template ami
  variable "ami" {
  type = string
  default = "ami-091a906f2e1e40076"
}