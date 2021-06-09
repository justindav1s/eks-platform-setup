# Continous Delivery & Image versioning 

## Step 1 : dev
  
We will use Semantic Versioning (https://devhints.io/semver) because flux auto image deployer policies require it

for a given image version begins with : 1.0.0

and increases 1.0.1, 1.0.2, 1.0.3 ->>>

following a minor release this would be 1.1.1, 1.1.2, 1.1.3 ->>>

TASK: manage the semver range in the Image Policy, as major and minor releases happen 

# Step 2 : promotion to E2E
   
Image is tagged with new name ? This does not have to be semver compliant as we are not using auto image deployer policies on e2e (?)

or

we just call the image some like 1.1.3-rc1, 1.1.3-rc2

TASKS :
* Retag image with new tag
* Update appropriate HelmRelease with new tag
* Issue pull request on GitOPs repo and path for e2e (Pipeline could do the retag, by parsing the HelmRelease for desired tag name ?)

# Step 3 : promotion to Staging

Assumptions
1. Gitops Gitlab repo for Staging governed by a different group of MR approvers
2. Dev Team can issue pull request against it.
3. When MR approved Pipeline runs which :
   1. Parses HelmRelease to be Merged, which is the most recent used in e2e
   2. Extracts axtrct image path and tag from it
      * <e2e_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3-rc2
   3. Uses Skopeo(?) to copy image from 
      * <e2e_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3-rc2
      * to
      * <prd_account_id>.dkr.ecr.eu-west-2.amazonaws.com/inventory:1.1.3  
4. 
