variable "secrets" {
  type = map(object({
    name                    = string
    recovery-window-in-days = number
    random-password         = bool
  }))
}

variable "team_name" {
  type        = string
  description = "Team name"
}

variable "application" {
  type        = string
  description = "Application name"
}

variable "environment-name" {
  type        = string
  description = "Environment name"
}

variable "is-production" {
  default     = "false"
  description = "Whether the environment is production or not"
  type        = string
}

variable "namespace" {
  default     = ""
  description = "Namespace name"
  type        = string
}

variable "business-unit" {
  description = "Area of the MOJ responsible for the service"
  default     = ""
  type        = string
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>)"
  type        = string
}
