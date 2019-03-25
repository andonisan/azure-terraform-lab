variable "rg_names" {
  description = "Create RGs with these names"
  type        = map(string)
  default = {
    Spain    = "westeurope"
    France   = "northeurope"
    Portugal = "francecentral"
  }
}
