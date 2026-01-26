output "irsa_policy_arn" {
  value = aws_iam_policy.irsa_policy.arn
}

output "secret_names" {
  value = { for key in keys(var.secrets) : key => aws_secretsmanager_secret.secret[key].name }
}
