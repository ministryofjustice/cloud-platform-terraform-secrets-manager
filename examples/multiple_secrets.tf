module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=1.0.0"
  secrets = {
    "test-secret" = {
      workspace               = "cp-1508-1217",
      name                    = "test-secret",
      recovery-window-in-days = 0,
      password                = "create",
      team_name               = "test-team",
      application             = "test-application",
      business-unit           = "test-platform",
      is_production           = "false",
      namespace               = "test-namespace",
      environment             = "test-environment",
      infrastructure_support  = "test-support-team@test.gov.uk",




    },
    "test-secret" = {
      workspace               = "cp-1508-1217",
      name                    = "test-secret",
      recovery-window-in-days = 30,
      password                = "false",
      team_name               = "test-team",
      application             = "test-application",
      business-unit           = "test-platform",
      is_production           = "false",
      namespace               = "test-namespace",
      environment             = "test-environment",
      infrastructure_support  = "test-support-team@test.gov.uk",
    },
  }
}