resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-050825485402e992a"
}

resource "aws_subnet" "public"{
  vpc_id     = "vpc-050825485402e992a"
  cidr_block = "172.31.96.0/20"
}


resource "aws_lb" "test" {
  name               = "load-balancer-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-00972b3b452f3269a"]
  subnets            = ["subnet-0594982aa9652633a", "subnet-009a55e385d7da63b"]

  
}
resource "aws_launch_configuration" "as_conf" {
  name          = "demo_config"
  image_id      = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
}

resource "aws_launch_template" "my_launch_template"{
  name = "my-launch-template"
  image_id      = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
  key_name = "janaki"
  vpc_security_group_ids = ["sg-00972b3b452f3269a"]
}

resource "aws_autoscaling_group" "demo-asg" {
  name                      = "demo-asg-tf"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier = ["subnet-0594982aa9652633a", "subnet-009a55e385d7da63b"]

}

