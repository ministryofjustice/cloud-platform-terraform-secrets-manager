variable "secrets" {
  type = map(object({
    workspace               = number
    name                    = string
    recovery_window_in_days = number
    application             = string
    business-unit           = string
    password                = string
    secret_string           = string
  }))
}