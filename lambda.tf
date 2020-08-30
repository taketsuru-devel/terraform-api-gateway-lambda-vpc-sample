resource "aws_lambda_permission" "api_gateway_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"


  # The /*/*/* part allows invocation from any stage, method and resource path within API Gateway REST API.
  source_arn = format("%s/*/*/*", aws_api_gateway_rest_api.this.execution_arn)
}

data "archive_file" "source_code" {
  type        = "zip"
  source_file = "./src/index.py"
  output_path = "./dist/source.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = format("%s-lambda", var.project_name)
  role             = aws_iam_role.this.arn
  runtime          = "python3.6"
  handler          = "index.lambda_handler"
  timeout          = 10
  vpc_config {
    subnet_ids = [aws_subnet.this.id]
    security_group_ids = [aws_security_group.this.id]
  }
  filename         = data.archive_file.source_code.output_path
  source_code_hash = data.archive_file.source_code.output_base64sha256
}
