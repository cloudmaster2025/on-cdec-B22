terraform {
  backend "s3" {
   region = "ap-south-1"
   bucket = "mybucket1645451"
   key = "latest.tf"
}
}

