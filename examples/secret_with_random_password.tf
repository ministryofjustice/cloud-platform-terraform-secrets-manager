module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=1.0.0"
  secrets = {
    "test-secret" = {
      workspace               = "cp-1508-1217",
      name                    = "test-secret",
      recovery-window-in-days = 0,
      application             = "test-application",
      business-unit           = "test-platform",
      password                = "create",
    },
  }
}