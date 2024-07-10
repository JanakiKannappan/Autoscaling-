resource "aws_instance" "web" {
  ami = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
  
}
resource "aws_security_group" "TF-SG" {
  name        = "Demo_sg_tf"
  vpc_id      = "vpc-050825485402e992a"
 
}

resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.TF-SG.id
 cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.TF-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

