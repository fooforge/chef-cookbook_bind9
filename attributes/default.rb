default[:bind9][:enable_ipv6] = true

# Allow only local clients to query the nameserver, with recursion
default[:bind9][:allow_query] = ["localnets", "localhost"]
default[:bind9][:allow_recursion] = ["localnets", "localhost"]

# Don:t allow to mess with zone files by default
default[:bind9][:allow_transfer] = ["none"]
default[:bind9][:allow_update] = nil

# default forwarders @ Google
default[:bind9][:enable_forwarding] = true
default[:bind9][:forwarders] = ["8.8.8.8", "8.8.4.4"]

# Allow user to enable DDNS
default[:bind9][:enable_ddns] = false
default[:bind9][:ddns_algorithm] = nil
default[:bind9][:ddns_secret] = nil

case platform
when "centos","redhat","fedora","scientific","amazon"
  default[:bind9][:config_path] = "/etc/named"
  default[:bind9][:config_file] = "/etc/named.conf"
  default[:bind9][:options_file] = "/etc/named/named.conf.options"
  default[:bind9][:local_file] = "/etc/named/named.conf.local"
  default[:bind9][:data_path] = "/var/named"
  default[:bind9][:log_path] = "/var/log/bind"
  default[:bind9][:user] = "named"
when "smartos"
  default[:bind9][:config_path] = "/opt/local/etc"
  default[:bind9][:options_file] = "/opt/local/etc/named.conf.options"
  default[:bind9][:local_file] = "/opt/local/etc/named.conf.local"
  default[:bind9][:data_path] = "/var/named"
  default[:bind9][:log_path] = "/var/log/named"
  default[:bind9][:user] = "root"
else
  default[:bind9][:config_path] = "/etc/bind"
  default[:bind9][:options_file] = "/etc/bind/named.conf.options"
  default[:bind9][:local_file] = "/etc/bind/named.conf.local"
  default[:bind9][:data_path] = "/var/cache/bind"
  default[:bind9][:log_path] = "/var/log/named"
  default[:bind9][:user] = "bind"
end
