output "irsa_policy_arn" {
  value = aws_iam_policy.irsa_policy.arn
}

# output "secret_ids" {
#   description = "The IDs of the AWS Secrets Manager secrets."
#   value       = { for k, v in aws_secretsmanager_secret.secret : k => v.id }
# }

# Create output for OpenSearch Alert Module, assume only the one secret in this case
output "secret_id" {
  description = "The ID of the AWS Secrets Manager secret."
  value       = values(aws_secretsmanager_secret.secret)[0].id
}