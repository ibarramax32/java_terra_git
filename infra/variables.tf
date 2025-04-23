variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for app artifacts"
  type        = string
  default     = "my-elasticbeanstalk-bucket"
}

variable "app_name" {
  description = "Elastic Beanstalk application name"
  type        = string
  default     = "my-java-app"
}

variable "env_name" {
  description = "Elastic Beanstalk environment name"
  type        = string
  default     = "my-java-env"
}