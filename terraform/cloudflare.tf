data "cloudflare_zone" "oluopeodu" {
  filter = {
    name = "oluopeodu.com"
  }
}


resource "cloudflare_dns_record" "google_verification" {
  zone_id = data.cloudflare_zone.oluopeodu.id
  name    = "oluopeodu.com"
  type    = "TXT"
  content = "WJnXa8RIF3Wx9ArhOzyjq-rp8DQxBSMOUFzoYq1C_TM"
  ttl     = 300
}


resource "cloudflare_dns_record" "google_mx" {
  zone_id  = data.cloudflare_zone.oluopeodu.id
  name     = "oluopeodu.com"
  type     = "MX"
  content  = "smtp.google.com"
  priority = 1
  ttl      = 300
}
