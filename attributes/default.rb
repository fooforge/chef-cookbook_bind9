# Allow all clients to query the nameserver, no recursion
default[:bind9][:allow_query] = nil
default[:bind9][:allow_recursion] = "none"

# Don:t allow to mess with zone files by default
default[:bind9][:allow_transfer] = "none"
default[:bind9][:allow_update] = nil
default[:bind9][:forwarders] = [ "4.4.4.4", "8.8.8.8" ]
