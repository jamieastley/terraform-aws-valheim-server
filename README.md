## Valheim Server


### Required env vars

- `AWS_ACCESS_KEY_ID`
- `AWS_REGION`
- `AWS_SECRET_ACCESS_KEY`

<details>
<summary>Module terraform.tfvars</summary>

```terraform
dns_email_address         = "abc@gmail.com"
hosted_zone_name          = "domain.com"
subdomain_name            = "valheim"
app_name                  = "valheim"
aws_ami                   = "ami-0e040c48614ad1327"
aws_region                = "ap-southeast-2"
enable_ssl_staging        = true
s3_bucket_name            = "game-servers"
s3_bucket_path            = "valheim"
ec2_username              = "ubuntu"
valheim_world_name        = "valheim-world"
valheim_server_password   = "hunter2"
valheim_server_type       = "Vanilla"
environment               = "dev" # (optional) defaults to "dev"
aws_instance_type         = "t3a.medium" # (optional) t3a.medium is the minimum recommended instance type
aws_access_key            = "<your access key>"
aws_secret_key            = "<your secret key>"
docker_image              = "mbround18/valheim:latest"
valheim_hugin_webhook_url = "https=//discord.com/api/webhooks/<your webhook url>"
```

</details>


## TODOs

- fix `terraform destroy` not removing docker compose file
- update README
- add required IAM permissions
