TF_PLAN_NAME = tf_plan

init:
	op run --env-file="aws.env" -- terraform init -backend-config="dev-state.config"

init_upgrade:
	terraform init -upgrade

plan:
	op run --env-file="aws.env" -- terraform plan -out=$(TF_PLAN_NAME)

apply_plan:
	op run --env-file="aws.env" -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file="aws.env" -- terraform destroy