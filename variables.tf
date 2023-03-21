variable "secrets" {
  type = map(object({
    workspace               = string
    name                    = string
    recovery-window-in-days = number
    password                = string
    team_name               = string
    business_unit           = string
    application             = string
    is_production           = string
    namespace              = string
    environment             = string
    infrastructure_support  = string
  }))
}