TF_PLAN_NAME = tf_plan
ENV_FILE = .env

bucket_init:
	op run --env-file="$(ENV_FILE)" -- terraform init

bucket_list_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace list

bucket_init_upgrade:
	terraform init -upgrade

bucket_plan:
	op run --env-file="$(ENV_FILE)" -- terraform plan -out=$(TF_PLAN_NAME)

bucket_apply_plan:
	op run --env-file="$(ENV_FILE)" -- terraform apply $(TF_PLAN_NAME)

bucket_destroy:
	op run --env-file="$(ENV_FILE)" -- terraform destroy
