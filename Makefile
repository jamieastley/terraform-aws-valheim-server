TF_PLAN_NAME = tf_plan
env_file = "local_debug.env"
workspace = "dev"

include local_debug.env

list_workspace:
	op run --env-file=$(env_file) -- terraform workspace list

new_dev_workspace:
	op run --env-file=$(env_file) -- terraform workspace new $(workspace)

# TODO: prefer -backend-config over workspaces, and have separate buckets for dev/prod
init:
	op run --env-file=$(env_file) -- terraform init -backend-config="bucket=${bucket}" -backend-config="key=${key}"

init_migration:
	terraform --version && op run --env-file=$(env_file) -- terraform init -migrate-state

init_upgrade:
	op run --env-file=$(env_file) -- terraform init -upgrade

plan:
	op run --env-file=$(env_file) -- terraform plan -out=$(TF_PLAN_NAME) -var-file=variables.tfvars

apply_plan:
	op run --env-file=$(env_file) -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file=$(env_file) -- terraform destroy -var-file=variables.tfvars