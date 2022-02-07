# Filename: main.tf
# Configure GCP project
provider "google" {
  project = "q-gcp-6508-rsg-docai-22-01"
}
# Deploy image to Cloud Run
resource "google_cloud_run_service" "cloudrun" {
  name     = "cloudrun"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello@sha256:1595248959b1eaac7f793dfcab2adaecf9c14fdf1cc2b60d20539c6b22fd8e4a"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
# Create public access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.cloudrun.location
  project     = google_cloud_run_service.cloudrun.project
  service     = google_cloud_run_service.cloudrun.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
# Return service URL
output "url" {
  value = "${https://cloudrun-ko7bzclbcq-uc.a.run.app}"
}
