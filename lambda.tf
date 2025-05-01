data "archive_file" "make_zip" {
  type        = "zip"
  source_file = "src/lambda_function.py"
  output_path = "src/lambda_function.zip"
}
resource "aws_lambda_function" "lambda" {
  function_name    = "testFunction"
  filename         = data.archive_file.make_zip.output_path
  source_code_hash = data.archive_file.make_zip.output_base64sha256
  role             = aws_iam_role.lambda_iam_role.arn
  handler          = "testFunction.lambda_handler"
  runtime          = "python3.11"
}