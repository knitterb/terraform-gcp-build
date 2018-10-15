
# Two Projects
This is how to deploy this build module across two projects.  One project is for hosting the repository and executing the Terraform templates, the other project is the target where the Terraform templates should be applied.

## Steps
- Create two projects
    - One project for the build (example: **project-build**)
    - Another project for the target (example: **project-target**)
- Create a service account in each project and download their keys (keep each service account credentials in a place and with a name you won't forget)
- In the **project-build** project create a source repository of your liking (synced from GitHub works well)
    - This will enable the API if it's not been used before
- Give the **project-build** service account rights to create and manipulate buckets within the **project-target** project.
- Enable the Cloud Build API for **project-target**
- Optional: Create a *tfvars* file with all the input variables
Give it a whirl by making a change or forcing the trigger to execute.

