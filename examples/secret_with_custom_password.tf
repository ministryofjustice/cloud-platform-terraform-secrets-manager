module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=concourse"
  secrets = {
    "test-secret" = {
      workspace               = "cp-1508-1217",
      name                    = "test-secret",
      recovery-window-in-days = 0,
      application             = "test-application",
      business-unit           = "test-platform",
      password                = "add",
      secret                  = var.password # variable-name is the name of the variable in the terraform.tfvars file. This is intended to used in paraellel with gitcrypt.
    },
  }
}