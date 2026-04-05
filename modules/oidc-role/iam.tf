# ---------------------------------------------------------------------------
# 1. Wildcard-resource actions (read-only describes + STS)
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "wildcard_actions" {
  statement {
    sid    = "WildcardResourceActions"
    effect = "Allow"
    actions = [
      "sts:GetCallerIdentity",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeVpcs",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeSubnets",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeAddresses",
      "ec2:DescribeAddressesAttribute",
      "ec2:DescribeNetworkInterfaces",
      "ec2:AssociateAddress",
      "ec2:ReleaseAddress",
      "ec2:DeleteKeyPair",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:DeletePolicy",
    ]
    resources = ["*"]
    # TODO: restrict by tags rather than wildcarding
  }
}

# ---------------------------------------------------------------------------
# 2. S3 – object-level actions (scoped to the /scripts directory)
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "s3_object_actions" {
  statement {
    sid    = "S3ObjectActions"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetObjectTagging",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*/scripts/*",
    ]
  }

  statement {
    sid    = "S3BucketVersioning"
    effect = "Allow"
    actions = [
      "s3:ListBucketVersions",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }
}

# ---------------------------------------------------------------------------
# 3. IAM – roles, policies, and instance profiles
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "iam_role_actions" {
  statement {
    sid    = "IAMRoleActions"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListInstanceProfilesForRole",
      "iam:DeleteRole",
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/*",
    ]
  }

  statement {
    sid    = "IAMPolicyActions"
    effect = "Allow"
    actions = [
      "iam:CreatePolicy",
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:policy/*",
    ]
  }

  statement {
    sid    = "IAMInstanceProfileActions"
    effect = "Allow"
    actions = [
      "iam:CreateInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:DeleteInstanceProfile",
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:instance-profile/*",
    ]
  }
}

# ---------------------------------------------------------------------------
# 4. EC2 – resource-scoped actions
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "ec2_resource_actions" {
  statement {
    sid    = "EC2VpcActions"
    effect = "Allow"
    actions = [
      "ec2:CreateVpc",
      "ec2:DescribeVpcAttribute",
      "ec2:DeleteVpc",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:vpc/*",
    ]
  }

  statement {
    sid    = "EC2KeyPairActions"
    effect = "Allow"
    actions = [
      "ec2:ImportKeyPair",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:key-pair/*",
    ]
  }

  statement {
    sid    = "EC2SecurityGroupActions"
    effect = "Allow"
    actions = [
      "ec2:CreateSecurityGroup",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:DeleteSecurityGroup",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:security-group/*",
    ]
  }

  statement {
    sid    = "EC2InternetGatewayActions"
    effect = "Allow"
    actions = [
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:internet-gateway/*",
    ]
  }

  statement {
    sid    = "EC2AttachDetachIGW"
    effect = "Allow"
    actions = [
      "ec2:AttachInternetGateway",
      "ec2:DetachInternetGateway",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:internet-gateway/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:vpc/*",
    ]
  }

  statement {
    sid    = "EC2SubnetActions"
    effect = "Allow"
    actions = [
      "ec2:CreateSubnet",
      "ec2:ModifySubnetAttribute",
      "ec2:DeleteSubnet",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:subnet/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:vpc/*",
    ]
  }

  statement {
    sid    = "EC2RouteTableActions"
    effect = "Allow"
    actions = [
      "ec2:CreateRouteTable",
      "ec2:CreateRoute",
      "ec2:AssociateRouteTable",
      "ec2:DeleteRouteTable",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:route-table/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:vpc/*",
    ]
  }

  statement {
    sid    = "EC2DisassociateRouteTable"
    effect = "Allow"
    actions = [
      "ec2:DisassociateRouteTable",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:route-table/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:subnet/*",
    ]
  }

  statement {
    sid    = "EC2ElasticIPActions"
    effect = "Allow"
    actions = [
      "ec2:AllocateAddress",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:elastic-ip/*",
    ]
  }

  statement {
    sid    = "EC2DisassociateAddress"
    effect = "Allow"
    actions = [
      "ec2:DisassociateAddress",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:elastic-ip/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:network-interface/*",
    ]
  }

  statement {
    sid    = "EC2RunInstances"
    effect = "Allow"
    actions = [
      "ec2:RunInstances",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:instance/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:network-interface/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:security-group/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:subnet/*",
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:volume/*",
      "arn:aws:ec2:${var.aws_account_region}::image/*",
    ]
  }

  statement {
    sid    = "EC2InstanceActions"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstanceAttribute",
      "ec2:TerminateInstances",
    ]
    resources = [
      "arn:aws:ec2:${var.aws_account_region}:${var.aws_account_id}:instance/*",
    ]
  }
}

# ---------------------------------------------------------------------------
# Merge all policy documents into one
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "github_actions_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.wildcard_actions.json,
    data.aws_iam_policy_document.s3_object_actions.json,
    data.aws_iam_policy_document.iam_role_actions.json,
    data.aws_iam_policy_document.ec2_resource_actions.json,
  ]
}

# ---------------------------------------------------------------------------
# Create the IAM policy and attach it to the OIDC role
# ---------------------------------------------------------------------------
resource "aws_iam_policy" "iam_policy" {
  name        = "${local.app_name}-github-oidc-policy"
  description = "Least-privilege policy for GitHub Actions OIDC role"
  policy      = data.aws_iam_policy_document.github_actions_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = module.oidc_policies.oidc_role_name
  policy_arn = aws_iam_policy.iam_policy.arn
}