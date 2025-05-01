resource "aws_iam_role" "lambda_iam_role" {
  name = "lambda_gitactions_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::152914900153:user/karan",
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::152914900153:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "ForAllValues:StringLike" : {
            "token.actions.githubusercontent.com:sub" : "repo:karan1316/*",
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}
resource "aws_iam_policy_attachment" "ec2_policy" {
  name       = "ec2-policy"
  roles      = [aws_iam_role.lambda_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}