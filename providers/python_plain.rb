#
# Author:: Noah Kantrowitz <noah@opscode.com>
# Cookbook Name:: application_python
# Provider:: plain
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

require 'tmpdir'

include Chef::DSL::IncludeRecipe

action :before_compile do
end

action :before_deploy do
end

action :before_migrate do

  if new_resource.requirements.nil?
    # look for requirements.txt files in common locations
    [
      ::File.join(new_resource.release_path, "requirements", "#{node.chef_environment}.txt"),
      ::File.join(new_resource.release_path, "requirements.txt")
    ].each do |path|
      if ::File.exists?(path)
        new_resource.requirements path
        break
      end
    end
  end
  if new_resource.requirements
    Chef::Log.info("Installing using requirements file: #{new_resource.requirements}")
    execute "#{new_resource.pip_path} install -r #{new_resource.requirements}" do
      command <<-EOC
      export PYTHONIOENCODING=UTF-8 PYCURL_SSL_LIBRARY=openssl LC_ALL=en_US.UTF-8 &&
      #{new_resource.pip_path} install -r #{new_resource.requirements} \
      --log #{new_resource.pip_log}
      EOC
      cwd new_resource.release_path
    end
  else
    Chef::Log.debug("No requirements file found")
  end

end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end
