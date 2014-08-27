default[:bind9][:enable_ipv6] = true

# Allow all clients to query the nameserver, no recursion
default[:bind9][:allow_query] = nil
default[:bind9][:allow_recursion] = "none"

# Don:t allow to mess with zone files by default
default[:bind9][:allow_transfer] = "none"
default[:bind9][:allow_update] = nil

default[:bind9][:enable_forwarding] = false
default[:bind9][:forwarders] = [ "4.4.4.4", "8.8.8.8" ]

case platform
when "centos","redhat","fedora","scientific","amazon"
  default[:bind9][:config_path] = "/etc/named"
	default[:bind9][:config_file] = "/etc/named.conf"
	default[:bind9][:options_file] = "/etc/named/named.conf.options"
	default[:bind9][:local_file] = "/etc/named/named.conf.local"
	default[:bind9][:data_path] = "/var/named"
  default[:bind9][:user] = "named"
else
  default[:bind9][:config_path] = "/etc/bind"
	default[:bind9][:config_file] = "/etc/bind/named.conf"
	default[:bind9][:options_file] = "/etc/bind/named.conf.options"
	default[:bind9][:local_file] = "/etc/bind/named.conf.local"
	default[:bind9][:data_path] = "/var/cache/bind"
  default[:bind9][:user] = "bind"
end
