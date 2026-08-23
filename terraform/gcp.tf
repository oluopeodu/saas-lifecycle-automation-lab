resource "google_project" "saas_lifecycle" {
  name 		      = "SaaS Lifecycle Automation"
  project_id	      = "saas-lifecycle-automation"
  org_id	      = "777363069673"
  billing_account     = "01EDDD-F45F5A-506FFC"
  auto_create_network = false
}
  
