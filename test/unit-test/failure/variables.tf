variable "eks_cluster_name" {
  description = "The name of the cluster (eg.: cloud-platform-live-0)"
  type        = string
  default     = "test"

}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service"
  type        = string
  default     = "test"
}

variable "application" {
  description = "Application name"
  type        = string
  default = "test"
}

variable "is_production" {
  description = "Whether this is used for production or not"
  type        = string
  default     = "false"
}

variable "team_name" {
  description = "Team name"
  type        = string
  default     = "test"
}

variable "namespace" {
  description = "Namespace name"
  type        = string
  default     = "test"
}

variable "environment_name" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>)"
  type        = string
  default     = "test"
}