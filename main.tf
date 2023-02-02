

//INTANCE CREATION

resource "aws_launch_template" "template" { 
  instance_type =  var.instance_type
  image_id = "ami-0ab0629dba5ae551d"
  key_name = aws_key_pair.demo_key.key_name

   tags = { 
    Name = var.env
  } 

  network_interfaces {
    associate_public_ip_address = var.public_ip
    security_groups = [var.sg_id]
  }
 
  user_data = base64encode("#!/bin/bash \nsudo su \napt install apache2 -y \nsystemctl start apache2 -y \nsystemctl enable apache2 -y \necho \"Hello, World!\" > /var/www/html/index.html")

  depends_on = [
    aws_key_pair.demo_key
  ]
}


//AUTOSCALING GROUP

resource "aws_autoscaling_group" "bar" {
  name = var.env
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size > var.desired_capacity ? var.max_size : var.desired_capacity 
  min_size           = var.min_size < var.desired_capacity ? var.min_size : var.desired_capacity
  target_group_arns = [aws_lb_target_group.main.arn]
  vpc_zone_identifier = var.sub_ids

  launch_template {
    id      = aws_launch_template.template.id
  }
  depends_on = [
    aws_launch_template.template,
    aws_lb_target_group.main
   ]
}


//LOAD BALANCER
resource "aws_lb" "test" {
  name               = var.env
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [var.sg_id]
  subnets            = var.sub_ids
  enable_deletion_protection = var.protect_from_delete

  tags = {
    Environment = "production"
  }
}