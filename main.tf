data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

data "aws_caller_identity" "current" {}

resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v }
  description             = each.value.description != "" ? each.value.description : "Secret for ${each.value.name}"
  name                    = "${each.value.namespace}/${each.value.name}"
  recovery_window_in_days = each.value.recovery-window-in-days # Set to 0 for no protection, between 7-30 days protection, default is 30.

  tags = {
    team-name              = each.value.team-name
    business-unit          = each.value.business-unit
    application            = each.value.application
    is-production          = each.value.is-production
    namespace              = each.value.namespace
    environment-name       = each.value.environment
    infrastructure-support = each.value.infrastructure-support
  }
}

resource "aws_iam_policy" "policy" {
  for_each    = { for k, v in var.secrets : k => v }
  name        = "${each.value.namespace}-policy-for-${each.value.name}-secret"
  path        = "/"
  description = "This policy is created to access the ${each.value.name} secret for the ${each.value.namespace} namespace."

  policy = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1682592071960",
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:secretsmanager:eu-west-2:${data.aws_caller_identity.current.account_id}:secret:${each.value.namespace}/${each.value.name}"
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
