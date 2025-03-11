resource "aws_instance" "p2_ec2" {
  ami           = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.p2_private_subnet.id
  security_groups = [aws_security_group.p2_ec2_sg.name]


  user_data = <<-EOF
              #!/bin/bash
              echo "Welcome to Cloud P2" > /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  tags = {
    Name = "PrivateEC2_P2"
  }
}
