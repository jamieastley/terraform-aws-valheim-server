# S3 Bucket Terraform Module

This module provisions the S3 bucket
via [terraform-s3-backend](https://registry.terraform.io/modules/jamieastley/s3-backend/aws/latest),
which will be used for transferring and backing up game data from the EC2 instance.

## Environment Variables

The environment variables are expected when using this module:

### AWS

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

### Terraform Cloud

- `TF_WORKSPACE`

## Terraform Variables

| Name     | Description                                                    | Type   | Required |
|----------|----------------------------------------------------------------|--------|----------|
| app_name | The name of the application to be used as the `bucket_prefix`. | string | yes      |

## Terraform Output Variables

| Name        | Description                                 |
|-------------|---------------------------------------------|
| bucket_name | The name of the S3 bucket that was created. |
| bucket_arn  | The ARN of the S3 bucket that was created.  |

## Makefile Targets

- `backend_init`: Initialize Terraform with environment variables.
- `backend_plan`: Create a Terraform plan.
- `backend_apply_plan`: Apply the Terraform plan.
- `backend_destroy`: Destroy all managed infrastructure.

## License

MIT
