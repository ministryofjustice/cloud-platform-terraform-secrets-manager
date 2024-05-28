output "irsa_policy_arn" {
  value = aws_iam_policy.irsa_policy.arn
}

output "secret_ids" {
  description = "The IDs of the AWS Secrets Manager secrets."
  value       = { for k, v in aws_secretsmanager_secret.secret : k => v.id }
}