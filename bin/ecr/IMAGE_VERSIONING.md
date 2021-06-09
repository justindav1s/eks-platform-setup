# Image versioning

## Step 1 : dev
  
We will use Semantic versioning because flux auto image deployer policies require it

for a given image version begins with : 1.0.0

and increases 1.0.1, 1.0.2, 1.0.3 ->>>

following a minor release this would be 1.1.1, 1.1.2, 1.1.3 ->>>

TASK: manage the semver Rage in the Image Policy, as major and minor releases hapen 

# Step 2 : promotion to E2E
   
Image is tagged with new name ? This does not have to be semver compliant as we are not using auto image deployer policies on e2e (?)

or

we just call the image some like 1.1.3-rc1, 1.1.3-rc2

TASKS :
* retag image with new nme
* update appropraite helm Release with new tag
* issue pull request on GitOPs repo and path for e2e (Pipeline could do the retag, by parsing the HelmRelease for desired tag name ?)

# Step 3 : promotion to Staging

Assumptions
1. Gitops Gitlab repo for Staging governed by a different group of MR approvers
2. Dev Team can issue pull request against it.
3. 
