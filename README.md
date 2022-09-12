# cloud-platform-terraform-secret-manager

This Terraform module is used to create and manage secret manager resources in the AWS.

## Usage

```
module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=1.0.0"
  secrets = {
    ["secret description"] = {
      workspace               = ["workspace name"],
      name                    = ["secret name"], 
      recovery-window-in-days = [0, 7 - 30],
      application             = ["application name for tag"], 
      business-unit           = ["bussiness unit for tag"],
      password                = ["false", "create"],
    },
  }
}
```

See the [examples](examples/) folder for examples on setting random passwords and adding multiple secrets.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.create_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | <pre>map(object({<br>    workspace               = string<br>    name                    = string<br>    recovery-window-in-days = number<br>    application             = string<br>    business-unit           = string<br>    password                = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.

<!--- END_TF_DOCS --->
