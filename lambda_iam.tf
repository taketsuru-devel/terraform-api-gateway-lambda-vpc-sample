data "aws_iam_policy_document" "lambda_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "this" {
  name = format("%s-lambda-role", var.project_name)

  assume_role_policy = data.aws_iam_policy_document.lambda_role.json 
}

resource "aws_iam_role_policy_attachment" "vpc_policy_attach" {
  role = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
