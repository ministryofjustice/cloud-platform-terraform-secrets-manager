variable "team_name" {
  description = "The name of your development team"
  default     = "webops"
}

variable "application" {
  description = "Name of Application you are deploying"
  default     = "example-app"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "Platforms"
}

variable "is_production" {
  default = "false"
}

variable "namespace" {
  default = "tom-namespace-dev"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "development"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "Platforms"
}

variable "eks_cluster_name" {
  description = "The name of the cluster (eg.: cloud-platform-live-0)"
  type        = string
  default     = "example_name"
}


variable "service_account_name" {
  description = "The name of the service account."
  type        = string
  default     = "example_name"
}


