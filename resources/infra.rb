# Copyright:: 2019, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource_name 'effortless_infra'

property :name, String, name_property: true
property :channel, String, default: 'stable'
property :origin, String, default: 'chef'
property :client_package, String, default: 'chef-client'
property :version, String
property :bldr_url, String
property :auth_token, String
property :org, String
property :peer, String
property :ring, String
property :listen_ctl, String, regex:/[0-255]\.[0-255]\.[0-255]\.[0-255]:\d+/
property :listen_gossip, String, regex:/[0-255]\.[0-255]\.[0-255]\.[0-255]:\d+/
property :listen_http, String, regex:/[0-255]\.[0-255]\.[0-255]\.[0-255]:\d+/
property :strategy, String, default: 'rolling'
property :topology, String, default: 'standalone'
property :service_group, String

if node['platform_family'].include?('windows')
  path = 'C:\opscode\chef'
else
  path = '/opt/chef'
end

load_current_value do
  version Chef::VERSION
end

action :install do
  hab_install
  hab_package "#{new_resource.origin}/#{new_resource.client_package}" do
    action :install
    version new_resource.version
    channel new_resource.channel
    bldr_url new_resource.bldr_url
    auth_token new_resource.auth_token
    notifies :run, 'execute[Link Chef Infra Binaries]'
  end

  package 'chef' do
    action :remove
    notifies :run, 'execute[Link Chef Infra Binaries]', :immediately
  end

  execute 'Link Chef Infra Binaries' do
    command "/bin/hab pkg binlink --force #{new_resource.origin}/#{new_resource.client_package}"
    action :nothing
  end

  directory path do
    action :delete
    recursive true
  end
end

action :enable do
  hab_sup 'default' do
    hab_channel new_resource.channel
    bldr_url new_resource.bldr_url
    auth_token new_resource.auth_token
    org new_resource.org
    peer new_resource.peer
    ring new_resource.ring
    listen_ctl new_resource.listen_ctl
    listen_gossip new_resource.listen_gossip
    listen_http new_resource.listen_http
  end

  hab_service "#{new_resource.origin}/#{new_resource.client_package}" do
    channel new_resource.channel
    strategy new_resource.strategy
    topology new_resource.topology
    bldr_url new_resource.bldr_url
    service_group new_resource.service_group
  end
end

def type
  if ::File.exist?(path)
    :omnibus
  else
    :habitat
  end
end
