# cloud-platform-terraform-secret-manager

This Terraform module is used to create and manage secret manager resources in the AWS.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.irsa_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [kubernetes_manifest.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.secret_store](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [random_id.secret_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.irsa_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Name of Application you are deploying | `string` | `"example-app"` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | Area of the MOJ responsible for the service. | `any` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The name of the eks cluster to use a secret prefix | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The type of environment you're deploying to. | `any` | n/a | yes |
| <a name="input_infrastructure_support"></a> [infrastructure\_support](#input\_infrastructure\_support) | The team responsible for managing the infrastructure. Should be of the form team-email. | `any` | n/a | yes |
| <a name="input_is_production"></a> [is\_production](#input\_is\_production) | n/a | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `any` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | <pre>map(object({<br>    description             = string<br>    recovery_window_in_days = number<br>    k8s_secret_name        = string<br>    k8s_secret_key = string<br>  }))</pre> | n/a | yes |
| <a name="input_serviceaccount_name"></a> [serviceaccount\_name](#input\_serviceaccount\_name) | The name of the service account to be used for the external secrets controller. | `string` | `"example_name"` | no |
| <a name="input_team_name"></a> [team\_name](#input\_team\_name) | The name of your development team | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_irsa_policy_arn"></a> [irsa\_policy\_arn](#output\_irsa\_policy\_arn) | The policy arn that grants access to the secret. |

<!--- END_TF_DOCS --->
