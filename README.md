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
      password                = ["false", "create"],
      team_name               = ["github team name"]
      business-unit           = ["Area of the MOJ responsible for the service."],
      application             = ["Name of Application you are deploying"], 
      is_production           = ["true", "false"]
      namespace               = ["namespace name"]
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Inputs

| Name | Description | Required |
|------|-------------|:--------:|
| workspace | name of the cluster | true |
name | name of the secret | true |
recovery-window-in-days | [0, 7 - 30] | true |
application | tag name of the application | true |
business-unit | tag name of the business unit | true |
password | [create, false] | true |

<!--- END_TF_DOCS --->
