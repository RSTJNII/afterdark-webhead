#
# Cookbook Name:: afterdark-webhead
# Recipe:: ssl
#
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

include_recipe 'afterdark-webhead::default'

require 'pathname'

# Install the SSL certs
ssl_dir_obj = Pathname.new('/etc/nginx/ssl')
directory ssl_dir_obj.to_s do
  owner 'root'
  group 'root'
  mode  0755
end

{ 'afterdark.cert.pem' => { source: node['afterdark-webhead']['ssl']['cert'],
                            mode: 0644
                          },
  'afterdark.key.pem' => { source: node['afterdark-webhead']['ssl']['key'],
                           mode: 0640
                         }
}.each_pair do |cert_file, cert_opts|
  cookbook_file ssl_dir_obj.join(cert_file).to_s do
    source   cert_opts[:source]
    cookbook node['afterdark-webhead']['ssl']['cert_cookbook']
    owner    'root'
    group    'www-data'
    mode     cert_opts[:mode]
    notifies :reload, 'service[nginx]', :delayed
  end
end

template '/etc/nginx/sites-available/000-afterdark-ssl' do
  source '000-afterdark.erb'
  mode 0644
  owner 'root'
  group 'root'
  notifies :reload, 'service[nginx]', :delayed
  variables(ssl: true,
            ssl_cert: ssl_dir_obj.join('afterdark.cert.pem'),
            ssl_key:  ssl_dir_obj.join('afterdark.key.pem'),
            )
end

nginx_site '000-afterdark-ssl' do
  enable true
end
