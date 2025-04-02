locals {
  repos = {
    for k, v in data.terraform_remote_state.repos.outputs.clone-urls :
    k => v.clone-urls
  }
}
