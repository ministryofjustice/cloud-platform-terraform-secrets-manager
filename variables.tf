variable "secrets" {
  type = map(object({
    name                    = string
    recovery-window-in-days = number
    random-password         = bool
    team_name               = string
    business_unit           = string
    application             = string
    is_production           = bool
    namespace               = string
    environment             = string
    infrastructure_support  = string
  }))
}