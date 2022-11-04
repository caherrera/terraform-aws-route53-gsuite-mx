data "aws_route53_zone" "domain_name" {
  name         = var.hosted_zone
  private_zone = false
}

# https://support.google.com/a/answer/174125?product_name=UnuFlow&hl=en&visit_id=638030992106258354-584500864&rd=1&src=supportwidget0&hl=en

locals {
  mx_records = {
    "aspmx" = {
      record   = "aspmx.l.google.com"
      priority = 1
    }
    "alt1" = {
      record   = "alt1.aspmx.l.google.com"
      priority = 5
    }
    "alt2" = {
      record   = "alt2.aspmx.l.google.com"
      priority = 5
    }
    "alt3" = {
      record   = "alt3.aspmx.l.google.com"
      priority = 10
    }
    "alt4" = {
      record   = "alt4.aspmx.l.google.com"
      priority = 10
    }
  }
}


resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.domain_name.id
  name    = ""
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 aspmx.l.google.com",
    "5 alt1.aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "10 alt3.aspmx.l.google.com",
    "10 alt4.aspmx.l.google.com"
  ]

}