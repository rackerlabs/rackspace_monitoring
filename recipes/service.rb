#
# Cookbook Name:: rackspace_monitoring
# Recipe:: service
#
# Copyright (C) 2015 Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

service "rackspace-monitoring-agent" do
  supports value_for_platform(
    "ubuntu" => { "default" => [:start, :stop, :restart, :status] },
    "default" => { "default" => [:start, :stop] }
  )

  case node[:platform]
    when "ubuntu"
    if node[:platform_version].to_f >= 9.10
      provider Chef::Provider::Service::Upstart
    end
  end

  action [:enable, :start]
  only_if { node['monitoring']['enabled'] == true }
end