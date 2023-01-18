resource "aws_instance" "ec2-21" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.nasr-subnet-w.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.nasrsgw.id]
  user_data = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
az=`curl http://169.254.169.254/latest/meta-data/placement/availability-zone`
ip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
sudo echo $az > /var/www/html/index.html
sudo echo $ip >> /var/www/html/index.html
EOF
}

resource "aws_instance" "ec2-22" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.nasr-subnet-w.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.nasrsgw.id]
  user_data = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
az=`curl http://169.254.169.254/latest/meta-data/placement/availability-zone`
ip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
sudo echo $az > /var/www/html/index.html
sudo echo $ip >> /var/www/html/index.html
EOF
}

