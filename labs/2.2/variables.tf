variable "sku-tier" {
  type = string
}

variable "sku-size" {
  type = string
}

variable "tags" {
  description = "The tags to associate with your resources."
  type        = map(string)
  default     = {}
}
