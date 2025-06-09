variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "mode" {
  description = "WAF policy mode: Prevention or Detection"
  type        = string
  default     = "Prevention"
}
variable "file_upload_limit_in_mb" {
  description = "File upload limit in MB"
  type        = number
  default     = 100
}
variable "max_request_body_size_in_kb" {
  description = "Max request body size in KB"
  type        = number
  default     = 128
}
variable "custom_rules" {
  description = "List of custom rules"
  type        = list(object({
    name         = string
    priority     = number
    rule_type    = string
    match_values = list(string)
    action       = string
  }))
  default = []
}
variable "owasp_version" {
  description = "OWASP managed rule set version"
  type        = string
  default     = "3.2"
}
variable "tags" {
  description = "Tags for WAF policy"
  type        = map(string)
  default     = {}
}
