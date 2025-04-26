TF_PLAN_NAME = tf_plan
env = "local.env"

init:
	op run --env-file=$(env) -- terraform init

init_upgrade:
	op run --env-file=$(env) -- terraform init -upgrade

plan:
	op run --env-file=$(env) -- terraform plan -out=$(TF_PLAN_NAME) -var-file=variables.tfvars

apply_plan:
	op run --env-file=$(env) -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file=$(env) -- terraform destroy -var-file=variables.tfvars