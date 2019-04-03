#
# Cookbook:: chef-client-hab-distro
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

hab_install
hab_package 'chef/chef-client' do
  binlink :force
end
