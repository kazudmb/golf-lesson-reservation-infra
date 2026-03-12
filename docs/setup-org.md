# AWS Organizations 初期設定
- AWSアカウントを作成する
  - メールアドレス：`nakano.kazuki.dmb+{project-short-name}@gmail.com`
  - アカウント名：`{project-name}`
- Organizations を有効化する
  - AWSコンソールから、手作業で有効化する
- Terraform state 用 S3 バケットを作成
  - AWSコンソールから、手作業で作成する
  - `<project>-org-state-<account>`
- `terraform/org/terraform.tfvars` が現在のプロジェクトの情報になっているか確認
- AWSコンソールからアクセスキーを手作業で作成
- 作成したアクセスキーをAWS_PROFILEに設定する
  - `aws configure --profile {project-short-name}-org`
- Terraform コマンドを実行
  ```sh
  cd terraform/org
  AWS_PROFILE={project-short-name}-org terraform init -reconfigure \
    -backend-config="bucket=<STATE_BUCKET>" \
    -backend-config="key=tfstate/org/terraform.tfstate" \
    -backend-config="region=ap-northeast-1"
  AWS_PROFILE={project-short-name}-org terraform plan -out=plan.bin
  tAWS_PROFILE={project-short-name}-org erraform apply -auto-approve plan.bin
  ```
