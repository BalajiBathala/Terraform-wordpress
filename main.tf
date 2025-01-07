resource "aws_instance" "wordpress" {
  ami           = "ami-088d38b423bff245f" # Replace with the appropriate AMI for your region
  instance_type = "t2.micro"              # Choose an instance type
  key_name      = "devops"                # Replace with your key pair name

  user_data = file("userdata.sh")

  tags = {
    Name = "WordPress-web-application"
  }

  security_groups = [aws_security_group.wordpress_sg.name]
}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-sg1"
  description = "Allow HTTP, HTTPS, and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update to specific IPs or security groups for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

