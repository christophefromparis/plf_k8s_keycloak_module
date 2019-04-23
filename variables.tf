# ------------------------
# ---    Kubernetes    ---
# ------------------------
variable "global_ns" {
  description = "The global namespace name"
}

# ------------------------
# --- The application ----
# ------------------------
variable "helm_version" {
  type = "map"
}
variable "keycloak_username" {
  description = "The administrator username"
}
variable "keycloak_password" {
  description = "The administrator password"
}
variable "fqdn_suffix" {
  description = "The FQDN suffix"
}