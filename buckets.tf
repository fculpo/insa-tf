resource "aws_s3_bucket" "incr" {
    count  = 10
    bucket =  "fculpo-incr-bucket-${count.index}"
}