variable "secrets" {
  type = map(object({
    workspace               = string
    name                    = string
    recovery-window-in-days = number
    application             = string
    business-unit           = string
    password                = string
    secret                  = string
  }))
}