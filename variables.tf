variable "secrets" {
  type = map(object({
    name                    = string
    recovery-window-in-days = number
    team-name               = string
    business-unit           = string
    application             = string
    is-production           = bool
    namespace               = string
    environment             = string
    infrastructure-support  = string
  }))
}