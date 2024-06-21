resource "aws_cloudwatch_log_group" "ci_function_bucket" {
  name              = "/aws/lambda/${local.base_name}-ci"
  retention_in_days = var.log_retention_days
}

resource "aws_lambda_function" "playground_ci" {
  function_name = "${local.base_name}-ci"
  description   = "Its a function. WITHOUT A SERVER!! UPDATED FROM CI!"
  s3_bucket     = module.placeholder_bucket.s3_bucket_id
  s3_key        = "lambda_function.zip"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  timeout       = 60

  environment {
    # variables = {
    #   HMAC_TOKEN_ARN     = aws_secretsmanager_secret.hmac_token.arn
    # }
    variables = {
      FOO = "BAZ"
    }
  }

  depends_on = [aws_cloudwatch_log_group.ci_function_bucket]
}

resource "aws_api_gateway_resource" "playground_ci" {
  rest_api_id = aws_api_gateway_rest_api.playground.id
  parent_id   = aws_api_gateway_rest_api.playground.root_resource_id
  path_part   = "handler-ci"
}

resource "aws_api_gateway_method" "playground_ci" {
  rest_api_id   = aws_api_gateway_rest_api.playground.id
  resource_id   = aws_api_gateway_resource.playground_ci.id
  http_method   = "POST"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.X-Foo-Signature" = false
  }
}

resource "aws_api_gateway_integration" "playground_ci_updated" {
  rest_api_id             = aws_api_gateway_rest_api.playground.id
  resource_id             = aws_api_gateway_resource.playground_ci.id
  http_method             = aws_api_gateway_method.playground_ci.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.playground_ci.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda_ci" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.playground_ci.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.playground.execution_arn}/*"
}
