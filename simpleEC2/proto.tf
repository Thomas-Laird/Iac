provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "deployer" {
  key_name = "${var.key_name}"
  public_key = "${var.public_key}"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  depends_on    = ["aws_s3_bucket.example"]
  tags = {  
    Name = "Terraform Generated"
  }
  key_name = "${aws_key_pair.deployer.key_name}"
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
  

  provisioner "file" {
    source = "ca.crt"
    destination = "/home/ubuntu/ca.crt"
  
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key= "${var.ssh_key}"
  }
 
  }
  
  provisioner "remote-exec" {
    inline = [ 
               "sudo mv /home/ubuntu/ca.crt /usr/local/share/ca-certificates/ca.crt",
               "sudo update-ca-certificates"
   ]
   connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${var.ssh_key}"
  }
}
}
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

resource "aws_s3_bucket" "example" {
  bucket = "thomaslairdterraform"
  acl    = "private"
}



