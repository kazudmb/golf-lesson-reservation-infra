## 目次
- [全体像](#全体像)
- [レポジトリ構成（2リポ）](#レポジトリ構成2リポ)
- [AWS Organizations 方針](#aws-organizations-方針)
- [CI/CD 方針](#cicd-方針)

---

## 全体像
- **目的**：S3/API Gateway/Lambda の“受け皿”を**インフラで固定**し、以後は**バックエンドを高速に更新**できる構成を作る。
- **ポイント**：
  - 環境は **`dev` / `stg` / `prd`**。
  - **Lambda のエイリアス名は `live` で固定**（全環境共通）。
  - **インフラは構成変更時のみ**。アプリは `main` マージで**自動デプロイ**。

---

## レポジトリ構成（2リポ）

### 1) `{product}-infra`
- 役割：Terraformで“受け皿”を作成（API Gateway、Lambda本体＋`live` エイリアス、S3 など）
- ディレクトリ指針：
  ```
  terraform/
    app/          # 環境別スタック
      dev/
      stg/
      prd/
    modules/      # 再利用モジュール
      backend/
      cognito/
      github_oidc/
    org/          # Organizations/OUs
  ```
- ルール：`main.tf` は**module呼び出し専用**にし、肥大化させない（実装は `modules/` に分割）

### 2) `{product}-backend`
- 役割：**Lambda コード（Python）**
- デプロイ：`main` マージ → **ビルド → S3 アップ → `update-function-code` → `publish-version` → `update-alias live`**

---

## AWS Organizations 方針
- 目的：`project` 配下に `dev/stg/prd` のOUとアカウントを揃える下地をつくる。
- 詳細手順は `docs/setup-org.md` を参照（Stateバケット作成、`terraform init/apply` のbackend設定例を含む）。

## AWS IAM User 方針
- `dev` / `stg` / `prd` 各OU配下のアカウントで、Root Userが IAM User を作成する。
- 手順の詳細は `docs/setup-user.md` を参照。

## CI/CD 方針
- トリガの基本：対象ブランチ（`main`/`stg`/`prd`）への **マージ・更新** を起点にActionsが走る（devは`main`、stg/prdは各ブランチに対応）。

### infra
- アクション：`terraform init` → `fmt` → `validate` → `plan -out=tfplan` → **保存した plan を apply**（差分なしなら apply はスキップ）

### backend
- アクション：
  1. 依存インストール → **zip作成**
  2. **S3** に`build.zip`をアップロード（`lambda/{product}-api-{env}/${GITHUB_SHA}.zip`）
  3. `aws lambda update-function-code`（$LATEST更新）
  4. `aws lambda publish-version`（不変版を確定）
  5. `aws lambda update-alias --name live --function-version <Version>`（入口を新Verに）

> ロールバック：`aws lambda update-alias --name live --function-version <旧版>` で即時戻し

---
