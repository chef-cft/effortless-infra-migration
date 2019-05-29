name 'effortless_infra_migration'
maintainer 'Chef Software, Inc'
maintainer_email 'support@chef.io'
license 'Apache-2.0'
description 'Migration tool for moving from omnibus to effortless patterns of Chef Infra'
long_description 'Migration tool for moving from omnibus to effortless patterns of Chef Infra'
version '0.1.0'
chef_version '>= 13.0'

issues_url 'https://github.com/chef-cft/effortless-infra-migration/issues'
source_url 'https://github.com/chef-cft/effortless-infra-migration'

supports 'ubuntu'
supports 'rhel'

depends 'habitat'

conflicts 'chef_client_updater'
conflicts 'chef-updater'
conflicts 'omnibus_updater'
