# Backend Terraform Module

This module provisions a Cloudflare R2 bucket for use as backend storage, typically for Terraform state or other application data. It is designed to be used in environments where Cloudflare R2 is preferred for object storage.

## Features
- Creates a Cloudflare R2 bucket with configurable name, location, and storage class.
- Uses Cloudflare provider (version ~> 5).
- Supports sensitive variable input for Cloudflare account ID.

## Usage

```hcl
module "backend" {
  source                  = "./modules/backend"
  cloudflare_account_id   = var.cloudflare_account_id
}
```

## Required Variables

| Name                   | Description                                              | Type   | Sensitive | Required |
|------------------------|----------------------------------------------------------|--------|-----------|----------|
| cloudflare_account_id  | The Cloudflare account ID where the R2 bucket is created | string | yes       | yes      |

## Resources Created
- `cloudflare_r2_bucket.valheim_r2_bucket`: The R2 bucket named `tf-valheim` in the `apac` location with `Standard` storage class.

## Providers
- [Cloudflare](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)

## Example

See the [main.tf](main.tf) for implementation details.

## Makefile Targets
- `backend_init`: Initialize Terraform with environment variables.
- `backend_plan`: Create a Terraform plan.
- `backend_apply_plan`: Apply the Terraform plan.
- `backend_destroy`: Destroy all managed infrastructure.

## Notes
- Cloudflare API token must be provided via the `CLOUDFLARE_API_TOKEN` environment variable.
- See `backend.env` for environment variable configuration.

## License
MIT

