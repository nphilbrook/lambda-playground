output "playground_apigw_url" {
  description = "API Gateway URL of the playground."
  value       = "${aws_api_gateway_stage.playground.invoke_url}/${aws_api_gateway_resource.playground.path_part}"
}

output "playground_ci_apigw_url" {
  description = "API Gateway URL of the playground-ci fuction."
  value       = "${aws_api_gateway_stage.playground.invoke_url}/${aws_api_gateway_resource.playground_ci.path_part}"
}

output "playground_lambda_invoke_arn" {
  value = aws_lambda_function.playground.invoke_arn
}

output "bucket_name" {
  value = module.placeholder_bucket.s3_bucket_id
}

# output "hcp_webhook_resource_name" {
#   description = "API resource name of the HCP notification webhook."
#   value       = hcp_notifications_webhook.aws.resource_name
# }
