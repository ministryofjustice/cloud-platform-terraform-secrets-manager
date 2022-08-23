# cloud-platform-terraform-secret-manager

This Terraform module is used to create and manage secret manager resources in the AWS.

## Usage

```
module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=concourse"
  secrets = {
    "test-secret" = {
      workspace               = "cp-1508-1217",
      name                    = "test-secret", 
      recovery-window-in-days = 0, 
      application             = "test-application", 
      business-unit           = "test-platform",
      password                = ["false", "add", "create"],
      secret                  = ["false", var.<variable-name>],
    },
  }
}
```

See the [examples](examples/) folder for examples on setting random and custom passwords.

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
recovery-window-in-days | [0 - 30] | true |
application | tag name of the application | true |
business-unit | tag name of the business unit | true |
password | [add, create, false] | true |
secret | [false, variable] | true |

<!--- END_TF_DOCS --->
