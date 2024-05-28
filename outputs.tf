output "irsa_policy_arn" {
  value = aws_iam_policy.irsa_policy.arn
}

output "secret_id" {
  value = aws_secretsmanager_secret.secret.id
}