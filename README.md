# Valheim Server

A collection of Terraform modules to deploy a Valheim server on AWS.

## Getting Started

### Prerequisites

The following prerequisites are required to run the module:

- A CloudFlare account with a domain which the subdomain record will be created in
- (Optional) A 1Password account to utilise the `MAKEFILE` commands
- An existing SSH key

### Game Server

#### Required env vars

AWS and CloudFlare credentials are expected to be available as environment variables prior to
running the module:

- `AWS_ACCESS_KEY_ID`
- `AWS_REGION`
- `AWS_SECRET_ACCESS_KEY`
- `CLOUDFLARE_API_TOKEN`

Then S3 backend block uses a partial configuration, so the following environment variables are also
expected to be set:

- `TF_VAR_bucket`
- `TF_VAR_key`
- `TF_VAR_region`

Remaining module variables can then be set via a `*.tfvars` file, or via environment variables (if
prefixed with `TF_VAR_`).

<details>
<summary>Example module *.tfvars</summary>

```terraform
app_name                  = "Valheim"
aws_ami                   = "ami-0e040c48614ad1327"
ec2_public_key            = "<ssh-public-key>"
s3_bucket_name            = "<S3-bucket-name>"
base_s3_key               = "<base-s3-key-path>"
ec2_username              = "<ec2-user>"
valheim_world_name        = "MyValheimWorld"
valheim_server_password   = "hunter2"
valheim_server_type       = "Vanilla"
docker_image              = "mbround18/valheim:<version>" # defaults to latest if var not set
valheim_hugin_webhook_url = "https://discord.com/api/webhooks/<your webhook url>"
dns_record_name           = "myawesomevalheimserver" # e.g. myawesomevalheimserver.mydomain.com
dns_zone_id               = "<CloudFlare-zone-id>"
environment               = "dev"

```

</details>

## TODOs

- add required IAM permissions
