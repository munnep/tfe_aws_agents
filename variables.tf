variable "tag_prefix" {
  description = "default prefix of names"
}

variable "region" {
  description = "region to create the environment"
}

variable "agent_token" {
  description = "agent secret token"
}

variable "vpc_cidr" {
  description = "which private subnet do you want to use for the VPC. Subnet mask of /16"
}

variable "ami" {
  description = "Must be an Ubuntu image that is available in the region you choose"
}

variable "rds_password" {
  description = "password for the RDS postgres database user"
}

variable "public_key" {
  type        = string
  description = "public to use on the instances"
}

variable "tfe_password" {
  description = "password for tfe user"
}

variable "filename_airgap" {
  description = "filename of your airgap installation located under directory airgap"
}

variable "filename_license" {
  description = "filename of your license located under directory airgap"
}

variable "filename_bootstrap" {
  description = "filename of your bootstrap located under directory airgap"
}

variable "terraform_client_version" {
  description = "Terraform client installed on the terraform client machine"
}

variable "dns_hostname" {
  description = "DNS hostname"
}

variable "dns_zonename" {
  description = "DNS zonename"
}

variable "certificate_email" {
  description = "email address to register the certificate"
}