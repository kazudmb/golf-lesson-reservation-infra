import {
  to = module.github_oidc.aws_iam_openid_connect_provider.github[0]
  id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
}

import {
  to = module.github_oidc.aws_iam_role.gha_infra[0]
  id = local.infra_role_name
}

import {
  to = module.github_oidc.aws_iam_role_policy_attachment.gha_admin[0]
  id = "${local.infra_role_name}/arn:aws:iam::aws:policy/AdministratorAccess"
}
