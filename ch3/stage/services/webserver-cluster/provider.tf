terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
  }
}
provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
}

resource "aws_instance" "example" {
  ami = "ami-07a52e291ed653aa8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello, world!" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF
  tags = {
    Name = "terraform-example"
  }
}