#
# Cookbook Name:: bind9
# Recipe:: default
#
# Copyright 2011, Mike Adolphs
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

package "bind9" do
  case node[:platform]
  when "centos", "redhat", "suse", "fedora", "smartos"
    package_name "bind"
  end
  action :install
end

directory node[:bind9][:log_path] do
  owner node[:bind9][:user]
  group node[:bind9][:user]
  mode 0775
  recursive true
  action :create
end

service "bind9" do
  case node[:platform]
  when "centos", "redhat", "fedora", "scientific", "amazon"
    service_name "named"
  when "smartos"
    service_name "dns/server:default"
  end
  supports :status => true, :reload => true, :restart => true
  action [ :enable ]
end

template node[:bind9][:config_file] do
  only_if { %w{centos redhat fedora scientific amazon smartos}.member? node[:platform] }
  source "named.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "bind9")
end

template node[:bind9][:options_file] do
  source "named.conf.options.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "bind9")
end

template node[:bind9][:local_file] do
  source "named.conf.local.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :zonefiles => search(:zones)
  })
  notifies :restart, resources(:service => "bind9")
end

search(:zones).each do |zone|
  unless zone['autodomain'].nil? || zone['autodomain'] == ''
    search(:node, "domain:#{zone['autodomain']}").each do |host|
      next if host['ipaddress'] == '' || host['ipaddress'].nil?
      zone['zone_info']['records'].push({
        "name" => host['hostname'],
        "type" => "A",
        "ip" => host['ipaddress']
      })
    end
  end

  template "#{node[:bind9][:data_path]}/#{zone['domain']}" do
    source "#{node[:bind9][:data_path]}/#{zone['domain']}.erb"
    local true
    owner "root"
    group "root"
    mode 0644
    notifies :restart, resources(:service => "bind9")
    variables({
      :serial => Time.new.strftime("%Y%m%d%H%M%S")
    })
    action :nothing
  end

  template "#{node[:bind9][:data_path]}/#{zone['domain']}.erb" do
    source "zonefile.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
      :domain => zone['domain'],
      :soa => zone['zone_info']['soa'],
      :contact => zone['zone_info']['contact'],
      :global_ttl => zone['zone_info']['global_ttl'],
      :nameserver => zone['zone_info']['nameserver'],
      :mail_exchange => zone['zone_info']['mail_exchange'],
      :records => zone['zone_info']['records']
    })
    notifies :create, resources(:template => "#{node[:bind9][:data_path]}/#{zone['domain']}"), :immediately
  end
end

service "bind9" do
  action [ :start ]
end

bash "selinux" do
  only_if { %w{centos redhat fedora scientific amazon}.member? node[:platform] }
  code "(sudo setsebool named_write_master_zones true) || true"
end
