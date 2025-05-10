terraform {
  backend "s3" {
    bucket = "ajari-new-bucket-77755566"
    region = "us-east-1"
    key = "jen101/terraform.tfstate"
  }
}