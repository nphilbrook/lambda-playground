locals {
  stage_name = "fun-stage"
}

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
### END API GW ACCOUNT-WIDE SETTING!!!!

data "aws_iam_policy_document" "api_gateway_resource_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::590184029125:role/aws_nick.philbrook_test-developer"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.playground.execution_arn}/*"]
  }
}

resource "aws_api_gateway_rest_api" "playground" {
  name        = local.base_name
  description = "Playground rest API"
  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_rest_api_policy" "playground" {
  rest_api_id = aws_api_gateway_rest_api.playground.id
  policy      = data.aws_iam_policy_document.api_gateway_resource_policy.json
}

resource "aws_api_gateway_resource" "playground" {
  rest_api_id = aws_api_gateway_rest_api.playground.id
  parent_id   = aws_api_gateway_rest_api.playground.root_resource_id
  path_part   = "handler"
}

resource "aws_api_gateway_method" "playground" {
  rest_api_id   = aws_api_gateway_rest_api.playground.id
  resource_id   = aws_api_gateway_resource.playground.id
  http_method   = "POST"
  authorization = "AWS_IAM"

  request_parameters = {
    "method.request.header.X-Foo-Signature" = true
  }
}

resource "aws_api_gateway_integration" "playground" {
  rest_api_id             = aws_api_gateway_rest_api.playground.id
  resource_id             = aws_api_gateway_resource.playground.id
  http_method             = aws_api_gateway_method.playground.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.playground.invoke_arn
}

resource "aws_api_gateway_deployment" "playground" {
  rest_api_id = aws_api_gateway_rest_api.playground.id
  depends_on = [
    aws_api_gateway_integration.playground,
    aws_api_gateway_integration.playground_ci_updated
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "playground" {
  deployment_id = aws_api_gateway_deployment.playground.id
  rest_api_id   = aws_api_gateway_rest_api.playground.id
  stage_name    = local.stage_name
}

resource "aws_cloudwatch_log_group" "playground_api_gateway" {
  count             = var.enable_api_gateway_logging ? 1 : 0
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.playground.id}/${local.stage_name}"
  retention_in_days = var.log_retention_days
}

resource "aws_api_gateway_method_settings" "playground" {
  count       = var.enable_api_gateway_logging ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.playground.id
  stage_name  = aws_api_gateway_stage.playground.stage_name
  method_path = "*/*"

  settings {
    logging_level      = var.api_gateway_logging_level
    metrics_enabled    = true
    data_trace_enabled = false
  }

  depends_on = [aws_cloudwatch_log_group.playground_api_gateway]
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.playground.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.playground.execution_arn}/*"
}
