TF_PLAN_NAME = tf_plan
ENV_FILE = backend.env
TF_WORKSPACE = dev

backend_init:
	op run --env-file="$(ENV_FILE)" -- terraform init

backend_list_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace list

backend_new_dev_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace new dev

backend_select_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace select $(TF_WORKSPACE)

backend_init_upgrade:
	terraform init -upgrade

backend_plan:
	op run --env-file="$(ENV_FILE)" -- terraform plan -out=$(TF_PLAN_NAME)

backend_apply_plan:
	op run --env-file="$(ENV_FILE)" -- terraform apply $(TF_PLAN_NAME)

backend_destroy:
	op run --env-file="$(ENV_FILE)" -- terraform destroy
