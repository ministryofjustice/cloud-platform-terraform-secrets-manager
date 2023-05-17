data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

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

}

resource "random_id" "secret_name" {
  byte_length = 12
}

resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v }
  description             = each.value.description != "" ? each.value.description : "Secret for ${each.value.name}"
  name                    = "${var.eks_cluster_name}-${var.namespace}-cloud-platform-${random_id.secret_name.b64_url}"
  recovery_window_in_days = each.value.recovery_window_in_days # Set to 0 for no protection, between 7-30 days protection, default is 30.
   tags = merge(
    {target-k8s-secret-name = "${each.value.k8s_secret_name}"},
    {target-k8s-secret-key = "${each.value.k8s_secret_key}"},
    local.default_tags
  )

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
  description = "Policy for accessing secrets via IRSA"
}

resource "kubernetes_manifest" "secret_store" {
  manifest = {
    "apiVersion" = "external-secrets.io/v1alpha1"
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
                "name" : var.serviceaccount_name
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
      "refreshInterval" = "1m"
      "secretStoreRef" = {
        "name" = local.secret_store_name
        "kind" = "SecretStore"
      }
      "target" = {
        "name" = "${aws_secretsmanager_secret.secret[each.key].tags["target-k8s-secret-name"]}"
      }
      "data" = [
        {
          "secretKey" = "${aws_secretsmanager_secret.secret[each.key].tags["target-k8s-secret-key"]}"
          "remoteRef" = {
            "key" = "${aws_secretsmanager_secret.secret[each.key].name}"
          }
        }
      ]
    }
  }
}

