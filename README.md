# cloud-platform-terraform-_template_

_note: Please remove all comments in italics and fill where required>_

_Please change the urls in the release badge below_
[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-template/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-template/releases)

_Short describion of the module_
_This Terraform module ......_

## Usage

```
module "secrets_manager" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=concourse"
  secrets = {
    "concourse_docker_username" = {
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

## Tags

Some of the inputs are tags. All infrastructure resources need to be tagged according to the [MOJ techincal guidance](https://ministryofjustice.github.io/technical-guidance/standards/documenting-infrastructure-owners/#documenting-owners-of-infrastructure). The tags are stored as variables that you will need to fill out as part of your module.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application |  | string | - | yes |
| business-unit | Area of the MOJ responsible for the service | string | `mojdigital` | yes |
| environment-name |  | string | - | yes |
| infrastructure-support | The team responsible for managing the infrastructure. Should be of the form team-email | string | - | yes |
| is-production |  | string | `false` | yes |
| team_name |  | string | - | yes |
| sqs_name |  | string | - | yes |

## Reading Material

_add link to external source_
