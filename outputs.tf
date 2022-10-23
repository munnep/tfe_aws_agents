output "ssh_tfe_server" {
  value = "ssh ubuntu@${var.dns_hostname}.${var.dns_zonename}"
}

output "tfe_dashboard" {
  value = "https://${var.dns_hostname}.${var.dns_zonename}:8800"
}

output "tfe_appplication" {
  value = "https://${var.dns_hostname}.${var.dns_zonename}"
}
