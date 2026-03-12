# Infra 初期設定
- AWSコンソールにログイン
  - `docs/setup-user.md`で作成したユーザーでログイン
- Terraform state 用 S3 バケット作成
  - name: `<project>-terraform-state-<account>`
  - バージョニング: ON
- ID プロバイダ作成
  - OpenID Connectを選択
  - プロバイダのURL: `https://token.actions.githubusercontent.com`
  - 対象者: `sts.amazonaws.com`
- GitHub Actions 用 IAM Role 作成
  - 名前: `<project>-infra-gha-ci`
  - 信頼ポリシー: 
    ```
    {
      "Version": "2012-10-17",
      "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::{account-id}:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": [
                        "repo:kazudmb/{project}-infra:ref:refs/heads/*",
                        "repo:kazudmb/{project}-infra:ref:refs/tags/*",
                        "repo:kazudmb/{project}-infra:pull_request",
                        "repo:kazudmb/{project}-infra:environment:*"
                    ]
                }
            }
        }
      ]
    }
    ```
  - 権限: `AdministratorAccess`（当面は最小権限化しない方針）
- GitHub Secrets Environment を作成
  - `dev` `stg` `prd` を作成
- GitHub Secrets に保存（`dev` `stg` `prd`）
  - `AWS_ROLE_ARN`: 作成した IAM Role の ARN
  - `TF_STATE_BUCKET`: 作成した Terraform state バケット名
- GitHub Variables に保存（`dev` `stg` `prd`）
  - `AWS_REGION`: `ap-northeast-1`
