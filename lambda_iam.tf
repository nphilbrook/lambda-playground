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
}



resource "aws_iam_role" "lambda_execution_role2" {
  name                = "${local.base_name}-lambda-role2"
  description         = "Execution role for philbrook-playground"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

resource "aws_iam_role" "lambda_execution_role3" {
  name                = "${local.base_name}-lambda-role3"
  description         = "Execution role for philbrook-playground"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}



resource "aws_iam_role" "lambda_execution_role4" {
  name                = "${local.base_name}-lambda-role4"
  description         = "Execution role for philbrook-playground"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}


resource "aws_iam_role" "lambda_execution_role5" {
  name                = "${local.base_name}-lambda-role5"
  description         = "Execution role for philbrook-playground"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}


resource "aws_iam_role" "lambda_execution_role6" {
  name                = "${local.base_name}-lambda-role6"
  description         = "Execution role for philbrook-playground"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}



locals {
  foo = "bar"
}

output "foo" {
  value = local.foo
}

output "foo2" {
  value = local.foo
}

output "foo3" {
  value = local.foo
}

output "foo4" {
  value = local.foo
}

output "foo5" {
  value = local.foo
}

output "foo6" {
  value = local.foo
}
