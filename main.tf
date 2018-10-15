provider "google" {
  project = "${var.project_id}"
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
      args = "cp gs://$PROJECT_ID-$REPO_NAME/credentials.json ."
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "build --network=host --build-arg BUCKET=${var.target_project_id}-$REPO_NAME -t gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA -f Dockerfile ."
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
