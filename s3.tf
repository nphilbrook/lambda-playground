module "placeholder_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~>4.1"

  bucket_prefix = "lambda-code-placeholder"
}

resource "aws_s3_bucket_object" "object" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object2" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key2"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object3" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key3"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object4" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key4"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object5" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key5"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object6" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key6"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object7" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key7"
  content = "foobar"
}

resource "aws_s3_bucket_object" "object8" {
  bucket  = module.placeholder_bucket.s3_bucket_id
  key     = "a_new_object_key8"
  content = "foobar"
}

