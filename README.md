# Lacework Terraform Cloud AWS Integration Example
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
