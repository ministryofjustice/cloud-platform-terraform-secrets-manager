variable "secrets" {
  type = map(object({
    name                    = string
    recovery-window-in-days = number
    random-password         = bool
    team-name               = string
    business-unit           = string
    application             = string
    is-production           = bool
    namespace               = string
    environment             = string
    infrastructure-support  = string
  }))
}