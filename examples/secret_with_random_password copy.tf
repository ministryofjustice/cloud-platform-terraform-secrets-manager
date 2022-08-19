module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=concourse"
  secrets = {
    "concourse_docker_username" = {
      workspace               = "cp-1508-1217",
      name                    = "test-secret",
      recovery-window-in-days = 0,
      application             = "test-application",
      business-unit           = "test-platform",
      password                = "create",
      secret                  = "false",
    },
  }
}