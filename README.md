# Lacework Terraform Cloud AWS Integration Example
[![IaC](https://app.soluble.cloud/api/v1/public/badges/cddb5b8c-0699-4311-be93-2c28b7f36ba2.svg?orgId=359062078604)](https://app.soluble.cloud/repos/details/github.com/anthonygrees/lw_tfc_aws_cloud_integration?orgId=359062078604)
[![HIPAA](https://app.soluble.cloud/api/v1/public/badges/a72347b7-e0b1-4eae-9df8-c762939b943a.svg?orgId=359062078604)](https://app.soluble.cloud/repos/details/github.com/anthonygrees/lw_tfc_aws_cloud_integration?orgId=359062078604)

This Terraform can be used on Terraform Cloud (TFC) to integrate your AWS Cloud account with Lacework.  
  
![TFC](/images/overview.png)
  
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
