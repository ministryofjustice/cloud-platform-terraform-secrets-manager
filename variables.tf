#################
# Configuration #
#################
variable "eks_cluster_name" {
  description = "The name of the eks cluster to use a secret prefix"
  type        = string
}

variable "secrets" {
  type = map(object({
    description             = string
    recovery_window_in_days = number
    k8s_secret_name         = string
  }))

  validation {
    condition = alltrue([for o in var.secrets : can(regex("^[a-z]([a-z0-9-.]*[a-z0-9])?$", o.k8s_secret_name))])
    error_message = "k8s_secret_name must be a valid k8s secret name (can only contain lowercase alphanumeric characters, numbers, dots and dashes. Must start with a letter and end with a letter or number)"
  }
}

########
# Tags #
########
variable "business_unit" {
  description = "Area of the MOJ responsible for the service"
  type        = string
}

variable "application" {
  description = "Application name"
  type        = string
}

variable "is_production" {
  description = "Whether this is used for production or not"
  type        = string
}

variable "team_name" {
  description = "Team name"
  type        = string
}

variable "namespace" {
  description = "Namespace name"
  type        = string
}

variable "environment_name" {
  description = "Environment name"
  type        = string
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>)"
  type        = string
}
