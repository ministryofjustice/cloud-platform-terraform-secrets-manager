variable "eks_cluster_name" {
  description = "The name of the eks cluster to use a secret prefix"
  type        = string
}
variable "secrets" {
  type = map(object({
    name                    = string
    description             = string
    recovery-window-in-days = number

  }))
}
variable "application" {
  description = "Name of Application you are deploying"
  default     = "example-app"
}

variable "namespace" {}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
}

variable "team_name" {
  description = "The name of your development team"
}

variable "environment" {
  description = "The type of environment you're deploying to."
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
}

variable "is_production" {
}

variable "serviceaccount_name" {
  description = "The name of the service account to be used for the external secrets controller."
  type        = string
  default     = "example_name"
}
variable "enable_external_secrets" {
  description = "Enable the external secrets controller."
  default     = "true"
}