output "secret_ids" {
  description = "Secret ids map"
  value       = { for k, v in aws_secretsmanager_secret.secret : k => v["id"] }
}

output "secret_arns" {
  description = "Secrets arns map"
  value       = { for k, v in aws_secretsmanager_secret.secret : k => v["arn"] }
}

output "irsa_policy_arn" {
    description = "IRSA policy arn"
    value       = aws_iam_policy.irsa_policy.arn
}