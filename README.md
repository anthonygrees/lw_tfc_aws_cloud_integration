# Lacework Terraform Cloud AWS Integration Example
[![IaC](https://app.soluble.cloud/api/v1/public/badges/cddb5b8c-0699-4311-be93-2c28b7f36ba2.svg?orgId=359062078604)](https://app.soluble.cloud/repos/details/github.com/anthonygrees/lw_tfc_aws_cloud_integration?orgId=359062078604)
[![HIPAA](https://app.soluble.cloud/api/v1/public/badges/a72347b7-e0b1-4eae-9df8-c762939b943a.svg?orgId=359062078604)](https://app.soluble.cloud/repos/details/github.com/anthonygrees/lw_tfc_aws_cloud_integration?orgId=359062078604)

This Terraform can be used on Terraform Cloud (TFC) to integrate your AWS Cloud account with Lacework.  
  
![TFC](/images/overview.png)
  
### Overview of AWS CloudTrail and Compliance Integration
To integrate AWS with Lacework, Lacework Terraform modules provision the following resources in the designated AWS account:  
`IAM Cross-Account Role` - A cross-account role is required to give access to Lacework access for assessments of cloud resource configurations and for analysis of CloudTrail events. The cross-account role will be given the following policies:  
 - `SecurityAudit` - AWS Managed Policy to provide read-only access to cloud resource configurations.  
 - `Lacework Custom Audit Policy` - A custom policy that extends SecurityAudit to enable read-only access to additional configuration resources.  
 - `Lacework Custom IAM Policy` - A custom policy that provides Lacework read-only access to ingest CloudTrail logs.  
  
`CloudTrail` - Lacework can create a new trail or use an existing CloudTrail.  
`S3 Bucket` - An S3 bucket is required for all CloudTrail integrations. Lacework can use an existing bucket or create a new bucket in the designated account.  
`SNS Topic` - An SNS topic is required for all CloudTrail integrations. Terraform can use an existing SNS topic or create one if an SNS topic has not be added to an existing CloudTrail.  
`SQS Queue` - An SQS queue is required for all CloudTrail integrations and monitored by Lacework.  
  
Full docs can be found here https://docs.lacework.com/onboarding/aws-cloudtrail-integration-with-terraform
  
### Requirements
`AWS Account Admin` - The account used to run Terraform must have administrative privileges on every AWS account you intend to integrate with Lacework.   
`AWS CLI` - The Terraform Provider for AWS leverages the configuration from the AWS CLI and it is recommended the AWS CLI is installed and configured with API Keys for the account being integrated.  
`Lacework Administrator` - You must have a Lacework account with administrator privileges.  
`Lacework CLI` - Lacework leverages the configuration from the Lacework CLI. It is recommended the Lacework CLI is installed and configured.  
`Terraform` - ~> 0.14, ~> 0.15, ~> 1.0, ~> 1.1.  
  
### 1. Lacework API Key
Login to Lacework and go to `Settings` -> `API Keys` -> `+ Add New`    
  
Download the Key.  
```bash
  account = "yourlacework"
  api_key = "LWINTREE_47243887356BA74XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  api_secret = "_4a69999999999999999999999999999"
  version = 2
```
  
### 2. Existing CloudTrail
If you are using an existing CloudTrail, you will need the `ARN` of the bucket.  
  
This will be added to the `variables` in TFC.
  
### 3. Set up Terraform Cloud
Add the repo to Terraform Cloud and add the following variables.
  
![TFC Vars](/images/variables.png)
  
### 4. Start New Run
In TFC, start a new run to complete the integration between your AWS Cloud Account and Lacework.  
  
![TFC Start](/images/start.png)
  
### 5. Completed Job
Once the Terraform Run is complete, it will look like this in TFC.
  
![TFC Complete](/images/complete.png)
  
Now check the Lacework Integration.  
  
In the Lacework UI, go to `Settings` -> `Cloud Accounts` and you will see the 2 new integrations.  They should go from yellow `Pending` to green `Success` after about 15 minutes.  
  
![LW Complete](/images/lwcomplete.png)
