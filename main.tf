data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v }
  description             = each.value.description != "" ? each.value.description : "Secret for ${each.value.name}"
  name                    = "${var.namespace}/${each.value.name}"
  recovery_window_in_days = each.value.recovery-window-in-days # Set to 0 for no protection, between 7-30 days protection, default is 30.

  tags = {
    team-name              = var.team_name
    business-unit          = var.business_unit
    application            = var.application
    is-production          = var.is_production
    namespace              = var.namespace
    environment-name       = var.environment
    infrastructure-support = var.infrastructure_support
  }
}

resource "aws_iam_policy" "policy" {
  for_each    = { for k, v in var.secrets : k => v }
  name        = "${var.namespace}-policy-for-${each.value.name}-secret"
  path        = "/"
  description = "This policy is created to access the ${each.value.name} secret for the ${var.namespace} namespace."

  policy = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1682592071960",
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:secretsmanager:eu-west-2:${data.aws_caller_identity.current.account_id}:secret:${var.namespace}/${each.value.name}"
        },
        {
            "Sid": "Stmt1682592135009",
            "Action": [
                "secretsmanager:ListSecrets"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
}
