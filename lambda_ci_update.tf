# data "archive_file" "playground_lambda" {
#   type        = "zip"
#   source_file = "${path.module}/function/lambda_function.py"
#   output_path = "${path.module}/function/lambda_function.zip"
# }

resource "aws_cloudwatch_log_group" "ci_function_bucket" {
  name              = "/aws/lambda/${local.base_name}-ci"
  retention_in_days = var.log_retention_days
}

# resource "aws_lambda_function" "playground_ci" {
#   function_name    = "${local.base_name}-ci"
#   description      = "Its a function. WITHOUT A SERVER!! UPDATED FROM CI!"
#   s3_bucket        = "s3://{module.placeholder_bucket.name.s3_bucket_id}"
#   s3_key           = 
#   filename         = data.archive_file.playground_lambda.output_path
#   source_code_hash = data.archive_file.playground_lambda.output_base64sha256
#   role             = aws_iam_role.lambda_execution_role.arn
#   handler          = "lambda_function.lambda_handler"
#   runtime          = "python3.10"
#   timeout          = 30

#   environment {
#     # variables = {
#     #   HMAC_TOKEN_ARN     = aws_secretsmanager_secret.hmac_token.arn
#     # }
#     variables = {
#       FOO = "BAR"
#     }
#   }

#   depends_on = [aws_cloudwatch_log_group.ci_function_bucket]
# }
