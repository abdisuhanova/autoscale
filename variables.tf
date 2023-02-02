
//IDs
variable "vpc_id" {}
    
variable "sg_id" {}

variable "sub_ids" {}



 //AUTOSCALING CAPACITY
variable "desired_capacity" {
    default = 1
}

variable "max_size" {
    default = 2
}

variable "min_size" {
    default = 1
}

//TYPEs
variable "instance_type" {
    default = "t2.micro"
}

variable "lb_type" {
    default = "application"
}

//NAMEs
variable "env" {
    default = "env"
}

variable "public_ip" {
    default = true
}
 
variable "protect_from_delete" {
    default = false
}

variable "lb_listener_ports" {
    default = 80
}

variable "lb_listener_protocols" {
    default = "HTTP"
}
