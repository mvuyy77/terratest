
terraform {
 backend "s3"{
  bucket = "table2user6terraform"
  key = "terra/state"
  region = "ap-southeast-2"
 }
}

provider "aws"{
 region = "ap-northeast-1"
}

provider "aws" {
 alias = "ap-southeast-2"
 region = "ap-southeast-2"
}

resource "aws_instance" "frontend"{
 depends_on = ["aws_instance.backend"]
 ami = "ami-02794be3fb6de50e1"
 instance_type = "t2.micro"
 key_name = "user6"
 tags = {
  Name = "table2User6-fe"
 }
 lifecycle {
  create_before_destroy = true
 }
}

resource "aws_instance" "backend"{
 provider = "aws.ap-southeast-2"
 ami = "ami-001dae151248753a2"
 instance_type = "t2.micro"
 key_name = "madhu"
 tags = {
  Name = "table2User6-be"
 }
 timeouts {
  create = "60m"
  delete = "2h"
 }
}
