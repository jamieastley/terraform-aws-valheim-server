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

## Determining least-privilege IAM roles

To easily determine the least-privilege IAM permissions required for the role, [iamlive](https://github.com/iann0036/iamlive/issues/74)
can be used while running the root module to generate the required policy document.

In a separate terminal window, run:
```shell
iamlive --set-ini --mode proxy
```

Then ensure these values are set within your Terraform terminal instance:
```shell
export HTTP_PROXY=http://127.0.0.1:10080
export HTTPS_PROXY=http://127.0.0.1:10080
export AWS_CA_BUNDLE=~/.iamlive/ca.pem
```


## References

- [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials)
- [Use IAM roles to connect GitHub Actions to actions in AWS](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)

## License

MIT
