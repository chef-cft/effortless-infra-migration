scaffold_policy_name="$policy_name"
pkg_name=effortless-infra-migration
pkg_origin=ncerny
pkg_version=$(awk '/^version/ { tmp=substr($2,2,length($2)-2); print tmp }' ../metadata.rb)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Chef $scaffold_policy_name Policy"
pkg_upstream_url="http://chef.io"
pkg_scaffolding="core/scaffolding-chef"
pkg_svc_user=("root")
pkg_exports=(
  [chef_client_ident]=chef_client_ident
)
scaffold_policyfiles_path="../"
