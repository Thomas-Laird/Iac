provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  depends_on    = ["aws_s3_bucket.example"]
  tags = {  
    Name = "Terraform Generated"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

resource "aws_s3_bucket" "example" {
  bucket = "thomaslairdterraform"
  acl    = "private"
}

resource "aws_instance" "anotherOne" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro" 
}

