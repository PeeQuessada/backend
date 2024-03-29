# First steps
# Create IAM User and download creadentials in the current folder
# export GOOGLE_APPLICATION_CREDENTIALS="./credentials.json"
# gcloud auth activate-service-account --key-file=<YOUR_SERVICE_ACCOUNT_KEY_FILE>
# gcloud config set project <PROJECT_ID>
# gcloud auth login

terraform {
  required_version = ">= 0.13"
  required_providers {
    google = ">= 5.17.0"
    local  = ">= 2.4.1"
  }
  backend "gcs" { # cloud storage
    # bucket = "us-central1-my-project-buckey-3"
    # prefix = "terraform/state/app"
  }
}

# gcloud config set compute/region <region> 
# gcloud config set compute/zone <zone>

