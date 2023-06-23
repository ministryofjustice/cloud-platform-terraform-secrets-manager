data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
}
locals {
  default_tags = {
    business-unit          = var.business_unit
    application            = var.application
    is-production          = var.is_production
    environment-name       = var.environment
    owner                  = var.team_name
    infrastructure-support = var.infrastructure_support
    namespace              = var.namespace
  }
  secret_store_name = "${var.namespace}-secrets-store"
  eso_irsa_serviceaccount_name = "secrets-store-${random_id.serviceaccount_id.hex}"
}

resource "random_id" "serviceaccount_id" {
  byte_length = 8
}

resource "random_id" "secret_name" {
  for_each                = var.secrets
  byte_length = 8
}

resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v }
  description             = each.value.description
  name                    = "${var.eks_cluster_name}-${var.namespace}-${random_id.secret_name[each.key].hex}"
  recovery_window_in_days = each.value.recovery_window_in_days != "" ? each.value.recovery_window_in_days : 30
   tags = merge(
    {target-k8s-secret-name = "${each.value.k8s_secret_name}"},
    local.default_tags
  )

}
module "irsa" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=2.0.0"
  eks_cluster_name =  var.eks_cluster_name
  namespace        = var.namespace
  role_policy_arns = {
    irsa = aws_iam_policy.irsa_policy.arn
  }
  service_account_name = local.eso_irsa_serviceaccount_name

   # Tags
  business_unit          = var.business_unit
  application            = var.application
  is_production          = var.is_production
  team_name              = var.team_name
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
}

data "aws_iam_policy_document" "irsa_policy" {
  statement {
    sid    = "Stmt1682592071960"
    effect = "Allow"

    actions   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
    resources = ["arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${var.eks_cluster_name}-${var.namespace}-*"]
  }
}

resource "aws_iam_policy" "irsa_policy" {
  name        = "${var.namespace}-irsa-policy-to-access-secrets"
  path        = "/${var.namespace}/"
  policy      = data.aws_iam_policy_document.irsa_policy.json
  description = "Policy for ESO to access secrets via IRSA"
}

resource "kubernetes_manifest" "secret_store" {
  manifest = {
    "apiVersion" = "external-secrets.io/v1beta1"
    "kind"       = "SecretStore"
    "metadata" = {
      "name"      = local.secret_store_name
      "namespace" = var.namespace
      "labels" = {
        "managed/by" : "terraform"
      }
    }
    "spec" = {
      "provider" = {
        "aws" : {
          "service" : "SecretsManager"
          "region" : data.aws_region.current.name
          "auth" : {
            "jwt" : {
              "serviceAccountRef" : {
                "name" : local.eso_irsa_serviceaccount_name
              }
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_manifest" "external_secrets" {
  for_each                = { for k, v in aws_secretsmanager_secret.secret : k => v }
  manifest = {
    "apiVersion" = "external-secrets.io/v1beta1"
    "kind"       = "ExternalSecret"
    "metadata" = {
      "name"      = "eks-external-secret-${aws_secretsmanager_secret.secret[each.key].tags["target-k8s-secret-name"]}"
      "namespace" = var.namespace
      "labels" = {
        "managed/by" : "terraform"
      }
    }
    "spec" = {
      "refreshInterval" = "1h"
      "secretStoreRef" = {
        "name" = local.secret_store_name
        "kind" = "SecretStore"
      }
      "target" = {
        "name" = "${aws_secretsmanager_secret.secret[each.key].tags["target-k8s-secret-name"]}"
      }
      "dataFrom" = [
        {
          "extract" = {
            "key" = "${aws_secretsmanager_secret.secret[each.key].name}"
          }
        }
      ]
    }
  }
}

