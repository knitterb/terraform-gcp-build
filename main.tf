provider "google" {
  project = "${var.project_id}"
  credentials = "credentials.json"
}

resource "google_storage_bucket" "terraform-bucket" {
  project  = "${var.project_id}"
  name     = "${var.project_id}-terraform"
  location = "us-west2"
}
resource "google_storage_bucket" "credential-bucket" {
  project  = "${var.target_project_id}"
  name     = "${var.target_project_id}-credentials"
  location = "us-west2"
}
resource "google_storage_bucket_object" "credentials" {
  name   = "credentials.json"
  source = "./credentials.json"
  bucket = "${google_storage_bucket.credential-bucket.name}"
}

resource "google_cloudbuild_trigger" "build_trigger" {
  trigger_template {
    branch_name = "master"
    project     = "${var.project_id}"
    repo_name   = "repo"
  }
  build {
    step {
      name = "gcr.io/cloud-builders/gsutil"
      args = "cp gs://${google_storage_bucket.credential-bucket.name}/credentials.json ."
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "build --network=host --build-arg BUCKET=${google_storage_bucket.terraform-bucket.name} -t gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA -f Dockerfile ."
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "run --network=host gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA plan -lock=true -lock-timeout=${var.lock_timeout}s -var project_id=${var.target_project_id}"
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "run --network=host gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA apply -lock=true -lock-timeout=${var.lock_timeout}s -auto-approve -var project_id=${var.target_project_id}"
    }
  }
}
