terraform {
  backend "s3" {
    bucket = "ajari-new-bucket-77755566"
    key    = "global-backend/terraform.tfstate"
    region = "us-east-1"
  }
}