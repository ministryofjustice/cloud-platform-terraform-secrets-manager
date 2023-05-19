
module "secrets_manager" {
  source = "../"
  // source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=1.1.0"
  team_name               = var.team_name
  application             = var.application
  business_unit           = var.business_unit
  is_production           = var.is_production
  namespace               = var.namespace
  environment             = var.environment
  infrastructure_support  = var.infrastructure_support
  eks_cluster_name       = var.eks_cluster_name

  secrets = {
    "test-secret-01" = {
      description             = "test secret", // Required
      recovery_window_in_days = 7, // Required
      k8s_secret_name        = "test-secret-01" // The name of the secret in k8s
      k8s_secret_key = "test-secret-01-key" // The key of the secret in k8s
    },
  }
}