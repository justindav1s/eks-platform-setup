# Continous Delivery & Image versioning 

## Step 1 : dev
  
We will use Semantic Versioning (https://devhints.io/semver) because flux auto image deployer policies require it

for a given image version begins with : 1.0.0

and increases 1.0.1, 1.0.2, 1.0.3 ->>>

following a minor release this would be 1.1.1, 1.1.2, 1.1.3 ->>>

TASK: manage the semver range in the Image Policy, as major and minor releases happen 

## Step 2 : promotion to E2E
   
Image is tagged with new name ? This does not have to be semver compliant as we are not using auto image deployer policies on e2e (?)

or

we just call the image some like 1.1.3-rc1, 1.1.3-rc2

### TASKS :
1. Retag image with new tag
2. Update appropriate HelmRelease with new tag
3. Issue pull request on GitOPs repo and path for e2e 
4. Pipeline retags the image, by parsing the HelmRelease for desired tag name
5. Flux 2 does the deploy.

## Step 3 : promotion to Staging

### TASKS :
1. Gitops Gitlab repo for Staging governed by a different group of MR approvers
2. Dev Team issue pull request against Staging repo by copying E2E Helm Release into Staging folder and/or repo.
3. When MR approved Pipeline runs which :
   1. Parses HelmRelease to be merged, which is the most recent used in e2e
   2. Extracts extract image path and tag from it
      * <e2e_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3-rc2
   3. Uses Skopeo(?) to copy image from 
      * <e2e_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3-rc2
      * to
      * <prd_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3  
4. Updates staging HelmRelease to use <prd_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3
5. Flux 2 does the deploy.

# Step 4 : promotion to Production

### TASKS :
1. SRE Team issue pull request on Production repo by copying Staging Helm Release into Production folder and/or repo.
2. MR approval updates Production HelmRelease to use <prd_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3
3. 5. Flux 2 does the deploy.