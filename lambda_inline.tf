locals {
  # hcp_org_name     = data.hcp_organization.current.name
  # hcp_project_name = data.hcp_project.current.name
  base_name = "philbrook-playground"
}

data "archive_file" "playground_lambda" {
  type        = "zip"
  source_file = "${path.module}/function/lambda_function.py"
  output_path = "${path.module}/function/lambda_function.zip"
}

resource "aws_cloudwatch_log_group" "webhook_function" {
  name              = "/aws/lambda/${local.base_name}"
  retention_in_days = var.log_retention_days
}

resource "aws_lambda_function" "playground" {
  function_name    = local.base_name
  description      = "Its a function. WITHOUT A SERVER!!"
  filename         = data.archive_file.playground_lambda.output_path
  source_code_hash = data.archive_file.playground_lambda.output_base64sha256
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.10"
  timeout          = 30

  environment {
    # variables = {
    #   HMAC_TOKEN_ARN     = aws_secretsmanager_secret.hmac_token.arn
    # }
    variables = {
      FOO = "BAR"
    }
  }

  depends_on = [aws_cloudwatch_log_group.webhook_function]
}
