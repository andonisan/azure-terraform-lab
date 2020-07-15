variable "rg_names" {
  description = "Create RGs with these names"
  type        = list(string)
  default     = ["Spain", "France", "Portugal"]
}


variable "rg_names_set" {
  description = "Create RGs with these names"
  type        = map(string)
  default = {
    Spain    = true
    France   = false
    Portugal = true
  }
}

variable "full_access" {
  description = "Full acces to resource groups"
  type        = bool
  default     = true
}
