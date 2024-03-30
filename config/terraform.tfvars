ec2 = {
  "vm-1" = {
    ami           = "ami-123"
    instance_type = "t2.micro"
    ec2-tags      = { Name = "vm-01" }
    user_data     = <<-EOF
		  #!/bin/bash
      sudo yum update
		  sudo yum install httpd -y
		  sudo systemctl start httpd
		  sudo systemctl enable httpd
		  echo "Hello from vm-01" > /var/www/html/index.html
      EOF
  }

  "vm-2" = {
    ami           = "ami-123"
    instance_type = "t2.micro"
    ec2-tags      = { Name = "vm-02" }
    user_data     = <<-EOF
		  #!/bin/bash
      sudo yum update
		  sudo yum install httpd -y
		  sudo systemctl start httpd
		  sudo systemctl enable httpd
		  echo "Hello from vm-02" > /var/www/html/index.html
      EOF
  }
}


tg = {
  "vpc_id"      = "vpc-123"
  "tg_name"     = "demo-tg"
  "tg_port"     = 80
  "tg_protocol" = "HTTP"
}


sg = {
  "ec2-sg" = {
    sg-tags = { Name = "ec2-sg" }
    vpc_id  = "vpc-123"

    ingress = {

      "rule-1" = {
        port = 80
        ip_protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
        security_groups = ""
      }

    }
  }

  "lb-sg" = {
    sg-tags = { Name = "lb-sg" }
    vpc_id  = "vpc-123"

    ingress = {

      "rule-1" = {
        port = 80
        ip_protocol = "TCP"
        cidr_blocks = "0.0.0.0/0"
        security_groups = ""
      }
      
    }
  }
}


alb = {
  alb_name        = "demo-lb"
  lb_type         = "application"
  internal        = false
  ip_address_type = "ipv4"
  subnets         = ["subnet-demo-1", "subnet-demo-2"]
  #listner config
  port     = 80
  protocol = "HTTP"
}

