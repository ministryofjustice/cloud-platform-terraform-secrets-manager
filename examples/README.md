# Example AWS Secrets Manager configuration

The configuration in this directory creates secrets in AWS Secrets Manager.

These examples are designed to be used in the [cloud-platform-environments](https://github.com/ministryofjustice/cloud-platform-environments/) repository.

## Usage

In your namespace's path in the [cloud-platform-environments](https://github.com/ministryofjustice/cloud-platform-environments/) repository, create a directory called `resources` (if you have not created one already) and refer to the contents of [secret.tf](secret.tf) to define the module properties. Make sure to change variable names to what is appropriate for your variables.tf

For each secret to be created on AWS Secrets Manager, update the map with a `key` e.g. `test-secret-01`, `description`, `recovery_window_in_days` and `k8s_secret_name`

The secret names in the AWS Secrets Manager are auto-generated and hence make sure to give a correct description while creating the secret. This will help identify the secret when updating the secret value from AWS console

To create multiple secrets, refer the [multiple_secrets.tf](multiple_secrets.tf).

Commit your changes to a branch and raise a pull request. Once approved, you can merge and the changes will be applied. 

Follow the [Cloud Platform - Secrets Manager](https://user-guide.cloud-platform.service.justice.gov.uk/documentation/deploying-an-app/add-secrets-to-deployment.html#adding-secrets-to-an-application) user guide on how to update the secret value. Once the secret value has been updated using AWS console, you will see a kubernetes_secret generated for every secret create above. You can decode the secret to check and refer to it in your deployment to fetch it from the kubernetes_secret.