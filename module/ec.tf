provider "aws" {
  region= "ap-southeast-1"
}
data "aws_ami" "latest_ami" {
  most_recent = "true"
  owners = ["amazon"]

  filter {
    name= "name"
    values= ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
resource "aws_security_group""my_sg" {
    name= "my_sg"
    description= "TCP"
    vpc_id= aws_vpc.vpc_01.id
    ingress {
        from_port  = 22 
        to_port = 22
        protocol = "TCP"
        cidr_blocks =["0.0.0.0/0"]
    }
    ingress {
        from_port  = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks =["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "my-instance" {
  ami=var.image_id
  instance_type= "t2.micro"
  key_name= ""
  vpc_security_group_ids=[aws_security_group.my_sg.id]
  subnet_id= aws_subnet.pub_sub.id
  user_data= filebase64 ("${path.module}/./script.sh")
#variable "image_id" {
#   type= string
#   default=""
#    description="Enter_my_value"
#}
output "kuldeep"{
    value= aws_instance.my-instance.public_ip
}