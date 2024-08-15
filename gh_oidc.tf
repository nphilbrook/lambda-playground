data "tls_certificate" "gha_certificate" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "gha_provider" {
  url             = data.tls_certificate.gha_certificate.url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.gha_certificate.certificates[0].sha1_fingerprint]
}
