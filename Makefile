TF_PLAN_NAME = tf_plan

init:
	op run --env-file="local.env" -- terraform init -backend-config="dev-state.config"

init_upgrade:
	op run --env-file="local.env" -- terraform init -upgrade

plan:
	op run --env-file="local.env" -- terraform plan -out=$(TF_PLAN_NAME) -var-file=variables.tfvars

apply_plan:
	op run --env-file="local.env" -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file="local.env" -- terraform destroy -var-file=variables.tfvars