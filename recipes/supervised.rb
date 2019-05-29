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

include_recipe "#{cookbook_name}::distributed"

hab_sup 'default'

hab_user_toml node['effortless']['pkg'] do
  config config_path: Chef::Config['config_file']
end

# Need to use my build until chef official builds are promoted, with changes in
# https://github.com/chef/chef/pull/8598
hab_service "#{node['effortless']['origin']}/#{node['effortless']['pkg']}" do
  retries 3
  channel node['effortless']['channel']
  strategy 'at-once'
  topology 'standalone'
end
