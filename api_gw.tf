data "aws_iam_policy_document" "apigw_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "api_gw_cloudwatch_role" {
  name                = "api-gw-cloudwatch-role"
  description         = "Role to allow API Gateway to log to CloudWatch"
  assume_role_policy  = data.aws_iam_policy_document.apigw_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"]
}

## API GW ACCOUNT-WIDE SETTING!!
resource "aws_api_gateway_account" "gw_account_cw_arn" {
  cloudwatch_role_arn = aws_iam_role.api_gw_cloudwatch_role.arn
}
