TF_WORKSPACE = valheim-dev
TF_PLAN_NAME = tf_plan
ENV_FILE = .env

oidc_role_init:
	op run --env-file="$(ENV_FILE)" -- terraform init

oidc_role_list_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace list

oidc_role_new_dev_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace new $(TF_WORKSPACE)

oidc_role_select_workspace:
	op run --env-file="$(ENV_FILE)" -- terraform workspace select $(TF_WORKSPACE)

oidc_role_init_upgrade:
	terraform init -upgrade

oidc_role_plan:
	op run --env-file="$(ENV_FILE)" -- terraform plan -out=$(TF_PLAN_NAME)

oidc_role_apply_plan:
	op run --env-file="$(ENV_FILE)" -- terraform apply $(TF_PLAN_NAME)

oidc_role_destroy:
	op run --env-file="$(ENV_FILE)" -- terraform destroy
