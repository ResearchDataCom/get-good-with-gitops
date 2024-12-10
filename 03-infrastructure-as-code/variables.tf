variable "STACK_NAME" {
  description = "Give this service a unique name."
  type        = string
  nullable    = false
}

variable "TAGS_ALL" {
  description = <<-EOT
    Apply these AWS metadata tags to all resources (JSON mapping tag
    names to values).
    EOT
  type        = string
  default     = "{}"
}
