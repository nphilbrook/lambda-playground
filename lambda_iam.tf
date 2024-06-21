data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# data "aws_iam_policy_document" "lambda_manage_ami" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "ec2:CreateTags",
#       "ec2:DeleteTags",
#       "ec2:DescribeImages",
#       "ec2:*ImageDeprecation",
#       "ec2:ModifyImageAttribute",
#       "ec2:DeregisterImage",
#       "ec2:DescribeSnapshots",
#       "ec2:DeleteSnapshot",
#     ]

#     resources = ["*"]
#   }
# }

# data "aws_iam_policy_document" "lambda_get_secrets" {
#   statement {
#     effect  = "Allow"
#     actions = ["secretsmanager:GetSecretValue"]

#     resources = [
#       aws_secretsmanager_secret.hmac_token.arn,
#     ]
#   }
# }

resource "aws_iam_role" "lambda_execution_role" {
  name                = "${local.base_name}-lambda-role"
  description         = "Execution role for philbrook-playground"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

  # inline_policy {
  #   name   = "lambda-manage-ami"
  #   policy = data.aws_iam_policy_document.lambda_manage_ami.json
  # }

  # inline_policy {
  #   name   = "lambda-get-secrets"
  #   policy = data.aws_iam_policy_document.lambda_get_secrets.json
  # }
}


