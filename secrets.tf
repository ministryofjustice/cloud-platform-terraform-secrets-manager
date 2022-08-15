resource "aws_secretsmanager_secret" "dockerhub_username" {
  count = var.concourse == "yes" ? 1 : 0
  description = "Dockerhub username"
  name = "/concourse/main/dockerhub_username"
  recovery_window_in_days = 0

  tags = {
    application   = "moj-cloud-platform"
    business-unit = "platforms"
  }
}

resource "aws_secretsmanager_secret" "dockerhub_password" {
  count = var.concourse == "yes" ? 1 : 0
  description = "Dockerhub password"
  name = "/concourse/main/dockerhub_password"
  recovery_window_in_days = 0

  tags = {
    application   = "moj-cloud-platform"
    business-unit = "platforms"
  }
}

resource "aws_secretsmanager_secret" "aws_creds_access_key_id" {
  count = var.concourse == "yes" ? 1 : 0
  description = "Dockerhub password"
  name = "/concourse/main/aws-creds-access-key-id"
  recovery_window_in_days = 0

  tags = {
    application   = "moj-cloud-platform"
    business-unit = "platforms"
  }
}

resource "aws_secretsmanager_secret" "aws_creds_secret_access_key" {
  count = var.concourse == "yes" ? 1 : 0
  description = "Dockerhub password"
  name = "/concourse/main/aws-creds-secret-access-key"
  recovery_window_in_days = 0

  tags = {
    application   = "moj-cloud-platform"
    business-unit = "platforms"
  }
}