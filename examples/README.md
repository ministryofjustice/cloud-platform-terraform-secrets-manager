# Example AWS Secrets Manager configuration

The configuration in this directory creates secrets in AWS Secrets Manager.

These examples are designed to be used in the [cloud-platform-environments](https://github.com/ministryofjustice/cloud-platform-environments/) repository.

## Usage

In your namespace's path in the [cloud-platform-environments](https://github.com/ministryofjustice/cloud-platform-environments/) repository, create a directory called `resources` (if you have not created one already) and refer to the contents of [secret.tf](secret.tf) to define the module properties. Make sure to change variable names to what is appropriate for your variables.tf

For each secret to be created on AWS Secrets Manager, update the map with a `key` e.g. `test-secret-01`, `description`, `recovery_window_in_days`, `k8s_secret_name` and the `k8s_secret_key`

To create multiple secrets, refer the [multiple_secrets.tf](multiple_secrets.tf).

Commit your changes to a branch and raise a pull request. Once approved, you can merge and the changes will be applied. Shortly after, you should be able to access the `Secret` on kubernetes and acccess the resources. You might want to refer to the [documentation on Secrets](https://kubernetes.io/docs/concepts/configuration/secret/).