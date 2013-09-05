#
# Author:: Noah Kantrowitz <noah@opscode.com>
# Cookbook Name:: application_python
# Resource:: python_plain
#
# Copyright:: 2011, Opscode, Inc <legal@opscode.com>
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

include ApplicationCookbook::ResourceBase

attribute :packages, :kind_of => [Array, Hash], :default => []
attribute :requirements, :kind_of => [NilClass, String, FalseClass], :default => nil
attribute :python_path, :kind_of => String, :default => 'python'
attribute :pip_path, :kind_of => String, :default => 'pip'
attribute :pip_log, :kind_of => String, :default => '~/.pip.log'
# Actually defaults to "settings.py.erb", but nil means it wasn't set by the user
attribute :debug, :kind_of => [TrueClass, FalseClass], :default => false
