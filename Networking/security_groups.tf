#Create a security group for the master node
resource "aws_security_group" "default" {
  name        = "ee_fastdata_sg"
  description = "Security group for the fastadata platform"
  vpc_id      = "${aws_vpc.tf_vpc.id}"
  
  #Allows SSH to hosts
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  #Allows all traffic internally
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr_block}}"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["${var.cidr_block}}"]
  }
  
  #Enables all outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags {
    Name = "Terraform Security Group"
  }
}