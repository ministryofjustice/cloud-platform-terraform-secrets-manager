<<<<<<< HEAD
variable "team_name" {
  description = "The name of your development team"
  default     = "webops"
}
=======
>>>>>>> acd3184f5c42b7c28fcbaaed4be1b26dd6b15ce0

variable "application" {
  description = "Name of Application you are deploying"
  default     = "example-app"
}

<<<<<<< HEAD
variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "Platforms"
}

variable "is_production" {
  default = "false"
}

variable "namespace" {
  default = "tom-namespace-dev"
=======
variable "namespace" {
  default = "example-team"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "Example"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "example"
>>>>>>> acd3184f5c42b7c28fcbaaed4be1b26dd6b15ce0
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "development"
}

<<<<<<< HEAD
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


=======
variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "example@digital.justice.gov.uk"
}

variable "is_production" {
  default = "false"
}
>>>>>>> acd3184f5c42b7c28fcbaaed4be1b26dd6b15ce0
