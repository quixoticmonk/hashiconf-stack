identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "dev" {
  inputs = {
    aws_role_arn    ="arn:aws:iam::697621333100:role/may-webinar-role"
    identity_token  = identity_token.aws.jwt
    environment     = "dev"
  }
  deployment_group = deployment_group.test_stack
  destroy=true


}

// deployment "test" {
//   inputs = {
//     aws_role_arn    ="arn:aws:iam::697621333100:role/may-webinar-role"
//     identity_token  = identity_token.aws.jwt
//     environment     = "test"
//   }
// deployment_group = deployment_group.test_stack
// }

deployment_group "test_stack" {
  auto_approve_checks = [
    deployment_auto_approve.no_destroy
  ]
}

deployment_auto_approve "no_destroy" {
  check {
    condition = context.plan.changes.remove == 0
    reason    = "Plan destroys ${context.plan.changes.remove} resources."
  }
}
