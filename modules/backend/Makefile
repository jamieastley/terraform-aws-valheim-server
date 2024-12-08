TF_PLAN_NAME = tf_plan

init:
	terraform init

init_upgrade:
	terraform init -upgrade

plan:
	op run --env-file="aws.env" -- terraform plan -out=$(TF_PLAN_NAME) -var-file=variables.tfvars

apply:
	op run --env-file="aws.env" -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file="aws.env" -- terraform destroy -var-file=variables.tfvars
