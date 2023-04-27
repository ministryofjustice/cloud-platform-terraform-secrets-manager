data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


locals {
  default_tags = {
    business-unit          = var.business-unit
    application            = var.application
    is-production          = var.is-production
    environment-name       = var.environment-name
    owner                  = var.team_name
    infrastructure-support = var.infrastructure-support
    namespace              = var.namespace
  }
 
}

# dynamtic secrets example 
resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v }
  description             = "Secret for ${each.value.name}"
  name                    = "${var.namespace}/${each.value.name}"
  recovery_window_in_days = each.value.recovery-window-in-days
  tags = local.default_tags
}

resource "aws_secretsmanager_secret_version" "create_secret_version" {
  for_each      = { for k, v in var.secrets : k => v if v.random-password == true }
  secret_id     = aws_secretsmanager_secret.secret[each.key].id
  secret_string = random_password.password[each.key].result == "false" ? "" : random_password.password[each.key].result

  depends_on = [aws_secretsmanager_secret.secret]
}

resource "random_password" "password" {
  for_each         = { for k, v in var.secrets : k => v if v.random-password == true }
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "aws_iam_policy_document" "irsa_policy" {
  statement {
    sid    = "IRSAGetSecrets"
    effect = "Allow"

    actions   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret" ]
     resources = [ "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${var.namespace}/*" ]
  }
}

resource "aws_iam_policy" "irsa_policy" {
  name        = "irsa-policy-to-access-secrets"
  path        = "/${var.namespace}/"
  policy      = data.aws_iam_policy_document.irsa_policy.json
  description = "Policy for accessing secrets via IRSA"
}
