resource "google_project" "saas_lifecycle" {
  name                = "SaaS Lifecycle Automation"
  project_id          = "saas-lifecycle-automation"
  org_id              = var.gcp_org_id
  billing_account     = var.gcp_billing_account
  auto_create_network = false
}

