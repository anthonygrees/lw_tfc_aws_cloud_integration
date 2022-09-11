##
## https://registry.terraform.io/modules/lacework/cloudtrail/aws/latest/examples/existing-cloudtrail-end-to-end-encryption
##
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
  ##
  ## As of version v1.0.0 of terraform-aws-cloudtrail module defaults to KMS-encrypted CloudTrail buckets and creates a new KMS key. 
  ## Optionally users can supply the ARN of their KMS key.  Access to this key will be granted to the Lacework IAM cross-account role.
  ## If encryption is being used
  ## KMS key ARN is usually in the form: arn:aws:kms:[aws_region]:[aws_account]:key/[value]
  ## bucket_sse_key_arn       = "arn:aws:kms:example-region-1:123456789098:key/111aa2bb-333c-4d44-5555-a111bb2c33dd"
  ##
  ## Remove consolidated_trail if not required.
  consolidated_trail      = true
  iam_role_arn            = module.aws_config.iam_role_arn
  iam_role_external_id    = module.aws_config.external_id
  iam_role_name           = module.aws_config.iam_role_name
  ## Remove if you do not have an existing CloudTrail and IAM to integrate with Lacework.
  use_existing_cloudtrail = true
  use_existing_iam_role   = true
  ##
  ## IMPORTANT !!
  ## If you do not have an existing SNS topic configured on the existing CloudTrail, 
  ## the Terraform module automatically creates one, but you must "manually" attach the SNS topic to the existing CloudTrail
  ## after the terraform has run.
  ## https://docs.lacework.com/onboarding/aws-cloudtrail-integration-with-terraform#about-sns-topics
  sns_topic_encryption_enabled = false
  use_existing_sns_topic = false
  ##sns_topic_arn = AWS_SNS_ARN
  ##
  ## If you need to configure multiple AWS account for Inventory only use this terraform
  ## https://docs.lacework.com/onboarding/aws-cloudtrail-integration-with-terraform#scenario-7---configure-multiple-aws-accounts
}
