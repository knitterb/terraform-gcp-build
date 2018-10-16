
# Two Projects
This is how to deploy this build module across two projects.  One
project is for hosting the repository and executing the Terraform
templates, the other project is the target where the Terraform
templates should be applied.

## Steps
- Create two projects
    - One project for the build (example: **project-build**)
    - Another project for the target (example: **project-target**)
- Create a service account in each project and download their keys
(keep each service account credentials in a place and with a name
you won't forget)
- In the **project-build** project create a source repository of your
liking (synced from GitHub works well)
    - This will enable the API if it's not been used before
- Give the **project-build** service account rights to create and
manipulate buckets within the **project-target** project.
- Enable the Cloud Build API for **project-target**
- Optional: Create a *tfvars* file with all the input variables
- Apply the build trigger Terraform scripts to **project-build**

Give it a whirl by making a change or forcing the trigger to execute.
Note that you may need to enable APIs in **project-target** that the
target Terraform scripts consume.

# One Project
This is how to deploy this build module within one project.  The one
project is used for both the build process as well as for the target
deployment of the Terraform scripts.

## Steps
- Create one project (example: **project-build-target**)
- Create a service account for the project and and download the keys
(keep the service account credentials in a place and with a name
you won't forget)
- Create a source repository in **project-build-target** (synced from
GitHub works well)
- Enable the Cloud Build API for **project-build-target**
- Optional: Create a *tfvars* file with all the input variables
- Apply the build trigger Terraform scripts to **project-build-target**

Give it a whirl by making a change or forcing the trigger to execute.
Note that you may need to enable APIs in **project-build-target** that
the target Terraform scripts consume.

