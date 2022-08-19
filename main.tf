provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

# dynamtic secrets example 
resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for k, v in var.secrets : k => v if v.workspace == terraform.workspace }
  description             = each.key
  name                    = each.value.name
  recovery_window_in_days = each.value.recovery-window-in-days

  tags = {
    application   = each.value.application
    business-unit = each.value.business-unit
  }
}

resource "aws_secretsmanager_secret_version" "add_secret_version" {
  for_each      = { for k, v in var.secrets : k => v if v.workspace == terraform.workspace && v.password == "add" }
  secret_id     = aws_secretsmanager_secret.secret[each.key].id
  secret_string = each.value.secret == "false" ? "" : each.value.secret

  depends_on = [aws_secretsmanager_secret.secret]
}

resource "aws_secretsmanager_secret_version" "create_secret_version" {
  for_each      = { for k, v in var.secrets : k => v if v.workspace == terraform.workspace && v.password == "create" }
  secret_id     = aws_secretsmanager_secret.secret[each.key].id
  secret_string = random_password.password[each.key].result == "false" ? "" : random_password.password[each.key].result

  depends_on = [aws_secretsmanager_secret.secret]
}

resource "random_password" "password" {
  for_each         = { for k, v in var.secrets : k => v if v.workspace == terraform.workspace && v.password == "create" }
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}