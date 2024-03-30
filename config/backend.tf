terraform {
  backend "s3" {
    bucket = "my-s3-bucket"
    key    = "tf_state"
    region = "us-east-1"
  }
}
