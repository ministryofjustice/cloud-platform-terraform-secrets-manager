# cloud-platform-terraform-secret-manager

This Terraform module is used to create and manage secret manager resources in the AWS.

## Usage

```
module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=1.0.0"
  secrets = {
    ["secret path"] = { ## (this should be `team_name/namespace/application` to make it easier to find secrets in the AWS console)
      name                    = ["secret name"], ## (uqique name for the secret that is used to reference the secret in the AWS console)
      recovery-window-in-days = [0, 7 - 30],
      random-password         = [true, false], ## (if true, a random password will be generated and stored in the secret)
      team_name               = ["github team name"] ## (this should be the same as the team name in the github repo)
      business-unit           = ["Area of the MOJ responsible for the service."],
      application             = ["Name of Application you are deploying"],
      is_production           = [true, false] 
      namespace               = ["namespace name"] ## (this should be the same as the namespace in the github repo)
      environment             = ["The type of environment you're deploying to."] 
      infrastructure_support  = ["The team responsible for managing the infrastructure. Should be of the form team-email."] 



    },
  }
}
```

See the [examples](examples/) folder for examples on setting random passwords and adding multiple secrets.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |

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
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | <pre>map(object({<br>    name                    = string<br>    recovery-window-in-days = number<br>    random-password         = bool<br>    team_name               = string<br>    business_unit           = string<br>    application             = string<br>    is_production           = bool<br>    namespace               = string<br>    environment             = string<br>    infrastructure_support  = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.

<!--- END_TF_DOCS --->
