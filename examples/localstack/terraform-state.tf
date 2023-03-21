provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "eu-west-2"
  s3_use_path_style           = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    apigatewayv2   = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    elasticache    = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

module "secrets_manager_localstack" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-secrets-manager?ref=concourse"
  secrets = {
    "test-secret" = {
      name                    = "test-secret",
      recovery-window-in-days = 0,
      random-password         = true,
      team_name               = "test-team",
      application             = "test-application",
      business_unit           = "test-platform",
      is_production           = false,
      namespace               = "test-namespace",
      environment             = "test-environment",
      infrastructure_support  = "test-support-team@test.gov.uk",
    },
    "test-secret" = {
      name                    = "test-secret",
      recovery-window-in-days = 30,
      random-password         = true,
      team_name               = "test-team",
      application             = "test-application",
      business_unit           = "test-platform",
      is_production           = false,
      namespace               = "test-namespace",
      environment             = "test-environment",
      infrastructure_support  = "test-support-team@test.gov.uk",
    },
  }
}
