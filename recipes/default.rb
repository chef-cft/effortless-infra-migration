#
# Cookbook:: chef-client-hab-distro
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

hab_install

hab_package 'chef/chef-client'

package 'chef' do
  action :remove
end

execute '/bin/hab pkg binlink chef/chef-client' do
  not_if { ::File.exist?('/bin/chef-client') }
end
