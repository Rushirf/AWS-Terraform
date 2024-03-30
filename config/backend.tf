terraform {
  backend "s3" {
    bucket = "rushi-s3-bucket-1"
    key    = "tf_state"
    region = "us-east-1"
  }
}