terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = "~> 0.16"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "lacework" {
  account    = var.my-account
  api_key    = var.my-api-key
  api_secret = var.my-api-secret
}

module "aws_config" {
  source  = "lacework/config/aws"
  version = "~> 0.5"
}

module "main_cloudtrail" {
  source                  = "lacework/cloudtrail/aws"
  version                 = "~> 2.0"
  ## Remove bucket_arn if you do not have an existing CloudTrail to integrate with Lacework.
  bucket_arn              = var.bucket-arn
  ## Remove consolidated_trail if not required.
  consolidated_trail      = true
  iam_role_arn            = module.aws_config.iam_role_arn
  iam_role_external_id    = module.aws_config.external_id
  iam_role_name           = module.aws_config.iam_role_name
  ## Remove if you do not have an existing CloudTrail and IAM to integrate with Lacework.
  use_existing_cloudtrail = true
  use_existing_iam_role   = true
}
