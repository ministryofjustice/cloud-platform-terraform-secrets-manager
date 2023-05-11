module "secrets_manager" {
  source = "../"
  team_name               = var.team_name
  application             = var.application
  business-unit           = var.business_unit
  is-production           = var.is_production
  namespace               = var.namespace
  environment-name        = var.environment
  infrastructure-support  = var.infrastructure_support
  
  secrets = {
    "tom-test-secret-01" = {
      name                    = "tom-test-secret-01",
      description             = "test secret",
      recovery-window-in-days = 0
    },
  }
}

// New users
module "irsa" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.1.0"

  eks_cluster_name =  var.eks_cluster_name
  namespace        = var.namespace
  role_policy_arns = [module.secrets_manager.irsa_policy_arn]
  service_account = var.service-account-name
}

resource "kubernetes_secret" "irsa" {
  metadata {
    name      = "irsa"
    namespace = var.namespace
  }
  data = {
    role           = module.irsa.aws_iam_role_name
    serviceaccount = module.irsa.service_account_name.name
  }
}

// Existing users who have IRSA 
// Add "module.secrets_manager.irsa_policy_arn" to the role_policy_arns in the irsa module
