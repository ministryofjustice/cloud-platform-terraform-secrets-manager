
module "secrets_manager_multiple_secrets" {
  source                 = "../"
  team_name              = var.team_name
  application            = var.application
  business_unit          = var.business_unit
  is_production          = var.is_production
  namespace              = var.namespace
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
  eks_cluster_name       = var.eks_cluster_name

  secrets = {

// the key "test-secret-01" is used to create kubernetes resource and must only contain lowercase alphanumeric characters, dots and dashes    
    "test-secret-01" = {
      description             = "test secret 01",
      recovery_window_in_days = 0
      k8s_secret_name         = "test-secret-01" # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
    // the key "test-secret-02" is used to create kubernetes resource and must only contain lowercase alphanumeric characters, dots and dashes
    "test-secret-02" = {
      description             = "test secret 02",
      recovery_window_in_days = 0
      k8s_secret_name         = "test-secret-02" # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
  }
}
