variable "cloudflare_account_id" {
  type        = string
  description = "cloudflare account ID to create the resources in"
}

variable "domain" {
  type        = string
  description = "The domain to create the zone for"
}

variable "enable_proton_mail" {
  type        = bool
  description = "Whether or not to enable Proton Mail domain verification"
  default     = false
}

variable "proton_mail_site_verifications" {
  type        = set(string)
  description = "An optional list of Proton Mail site verification strings"
  default     = []
}
variable "enable_fastmail" {
  type        = bool
  description = "Whether or not to enable Fastmail domain verification"
  default     = false
}