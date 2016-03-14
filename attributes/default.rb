#
# Cookbook Name:: afterdark-webhead
# Attributes:: default
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

default['afterdark-webhead']['content-user'] = 'ad-content'
default['afterdark-webhead']['content-group'] = 'ad-content'
default['afterdark-webhead']['content-path'] = '/var/www/afterdark'
default['afterdark-webhead']['content-source'] = 'https://github.com/RSTJNII/after-dark-css.git'

default['afterdark-webhead']['server-name'] = node['hostname']
