# Backend Terraform Module

This module provisions the S3 bucket
via [terraform-s3-backend](https://registry.terraform.io/modules/jamieastley/s3-backend/aws/latest),
which will be used for the main module of this repository.

## Environment Variables

The following AWS environment variables must be set:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

## Terraform Variables

| Name     | Description                                                    | Type   | Required |
|----------|----------------------------------------------------------------|--------|----------|
| app_name | The name of the application to be used as the `bucket_prefix`. | string | yes      |

## Makefile Targets

- `backend_init`: Initialize Terraform with environment variables.
- `backend_plan`: Create a Terraform plan.
- `backend_apply_plan`: Apply the Terraform plan.
- `backend_destroy`: Destroy all managed infrastructure.

## License

MIT
