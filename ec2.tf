resource "aws_instance" "p2_ec2" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.p2_private_subnet.id
  vpc_security_group_ids = [aws_security_group.p2_ec2_sg.id]


  user_data = <<-EOF
              #!/bin/bash
              sudo yum install httpd -y
              echo "Welcome to Cloud P2" > /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  tags = {
    Name = "PrivateEC2_P2"
  }
}
