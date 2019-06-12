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

hab_install do
  license node['chef_license']
end

hab_package "#{node['effortless']['origin']}/#{node['effortless']['pkg']}" do
  action :install
  channel node['effortless']['channel']
  notifies :remove, 'package[chef]'
  notifies :run, 'execute[Link Chef Infra Binaries]'
end

package 'chef' do
  action :nothing
  notifies :delete, 'directory[/opt/chef]'
end

directory '/opt/chef' do
  action :nothing
  recursive true
end

execute 'Link Chef Infra Binaries' do
  command "/bin/hab pkg binlink --force #{node['effortless']['origin']}/#{node['effortless']['pkg']}"
  action :nothing
end
