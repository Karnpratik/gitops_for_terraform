data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "pratik-bucketbackend1"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "pratik_bucket" {
  bucket = "com-pratik-bucket"

  tags = {
    Name = "pratikkarn-s3"
    Creator = "pratikkarn"
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.pratik_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "allowec2",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.terraform_remote_state.ec2.outputs.ec2_instance_arn}"
      },
      "Action": "s3:PutObject",
      "Resource" : "${aws_s3_bucket.pratik_bucket.arn}/*"
    }
  ]
}
POLICY
}


