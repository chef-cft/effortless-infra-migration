# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name "effortless_infra_migration"

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list ["effortless_infra_migration::default"]
named_run_list :distributed, ["effortless_infra_migration::distributed"]
named_run_list :supervised, ["effortless_infra_migration::supervised"]
named_run_list :managed, ["effortless_infra_migration::managed"]

cookbook 'effortless_infra_migration', path: '.'
