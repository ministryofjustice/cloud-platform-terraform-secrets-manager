module "secrets_manager_failure_localstack" {
  source = "../../.."

  eks_cluster_name       = var.eks_cluster_name
  team_name              = var.team_name
  application            = var.application
  business_unit          = var.business_unit
  is_production          = var.is_production
  namespace              = var.namespace
  environment_name       = var.environment_name
  infrastructure_support = var.infrastructure_support
  
  secrets = {
    "test-secret-failure-01" = {
      description             = ".test secret failure 01",
      recovery_window_in_days = 0
      k8s_secret_name         = ".test-secret-failure-01" # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
    "test-secret-failure-02" = {
      description             = "-test secret failure 02",
      recovery_window_in_days = 0
      k8s_secret_name         = "-test-secret-failure-02" # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
    "test-secret-failure-03" = {
      description             = "test secret failure 03",
      recovery_window_in_days = 0
      k8s_secret_name         = "03-test-secret-failure" # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
    "test-secret-failure-04" = {
      description             = "test secret failure 04",
      recovery_window_in_days = 0
      k8s_secret_name         = "03-test-secret-failure-04-" # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
    "test-secret-failure-05" = {
      description             = "test secret failure 05",
      recovery_window_in_days = 0
      k8s_secret_name         = "test-secret-failure.05." # The name of the secret in k8s and must only contain lowercase alphanumeric characters, dots and dashes
    },
  }
}