# OIDC Role Terraform Module

This module provisions an AWS IAM role for use with OIDC, which will be used by GitHub Actions to
authenticate to AWS.

## Environment Variables

The following AWS environment variables must be set:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

## Terraform Variables

| Name              | Description                                                  | Type   | Required |
|-------------------|--------------------------------------------------------------|--------|----------|
| oidc_provider_arn | The ARN of the OIDC provider to associate with the IAM role. | string | yes      |

## Outputs

| Name     | Description                                    |
|----------|------------------------------------------------|
| role_arn | The ARN of the IAM role created for OIDC auth. |

## Makefile Targets

- `oidc_role_init`: Initialise Terraform with environment variables.
- `oidc_role_list_workspace`: List available Terraform workspaces.
- `oidc_role_new_dev_workspace`: Create a new development workspace.
- `oidc_role_select_workspace`: Select the development workspace.
- `oidc_role_init_upgrade`: Upgrade Terraform providers.
- `oidc_role_plan`: Create a Terraform plan.
- `oidc_role_apply_plan`: Apply the Terraform plan.
- `oidc_role_destroy`: Destroy all managed infrastructure.

## References

- [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials)
- [Use IAM roles to connect GitHub Actions to actions in AWS](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)

## License

MIT
