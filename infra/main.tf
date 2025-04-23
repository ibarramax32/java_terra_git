provider "aws" {
  region = var.aws_region
}

data "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "app_war" {
  bucket = data.aws_s3_bucket.app_bucket.bucket
  key    = "app.war"
  source = "../../app.war"  # Path to app.war in repo root
}

resource "aws_elastic_beanstalk_application" "app" {
  name        = var.app_name
  description = "Simple Java App"
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                = var.env_name
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.7 running Corretto 17"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }
}

resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "${var.app_name}-v${formatdate("YYYYMMDDHHmmss", timestamp())}"
  application = aws_elastic_beanstalk_application.app.name
  description = "Application version created by Terraform"
  bucket      = data.aws_s3_bucket.app_bucket.bucket
  key         = aws_s3_object.app_war.key
}