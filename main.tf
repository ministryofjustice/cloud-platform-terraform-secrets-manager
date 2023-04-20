provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

# dynamtic secrets example 
resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v }
  description             = "Secret for ${each.value.name}"
  name                    = "${each.value.namespace}/${each.value.name}"
  recovery_window_in_days = each.value.recovery-window-in-days

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