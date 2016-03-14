#
# Cookbook Name:: afterdark-webhead
# Recipe:: content: Install the content of the site
#
# Copyright 2014, Rackspace, US Inc.
# Copyright 2016, Tom Noonan II
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
#

user node['afterdark-webhead']['content-user'] do
  comment 'AfterDark Web Content'
  system true
  shell '/bin/false'
end

group node['afterdark-webhead']['content-group'] do
  members node['afterdark-webhead']['content-user']
  append false
end

directory node['afterdark-webhead']['content-path'] do
  owner node['afterdark-webhead']['content-user']
  group node['afterdark-webhead']['content-group']
  mode 00755
  recursive true
  action :create
end

package 'git' do
  action :install
end

git node['afterdark-webhead']['content-path'] do
  repository node['afterdark-webhead']['content-source']
  user node['afterdark-webhead']['content-user']
  group node['afterdark-webhead']['content-group']
  action :sync
end
