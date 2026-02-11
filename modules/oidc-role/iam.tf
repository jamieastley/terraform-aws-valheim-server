# Define policy statements for GitHub Actions
data "aws_iam_policy_document" "iam_role_policies" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

# Create the IAM policy based on the policy document
resource "aws_iam_policy" "iam_policy" {
  name        = "${local.app_name}-s3-policy"
  description = "Allows full access to S3"
  policy      = data.aws_iam_policy_document.iam_role_policies.json
}

# Attach the policy to the OIDC role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = module.oidc_policies.oidc_role_name
  policy_arn = aws_iam_policy.iam_policy.arn
}
