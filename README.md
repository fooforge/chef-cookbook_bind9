Description
===========

Installation and configuration of BIND9.

Requirements
============

Platform:

* Debian
* Ubuntu
* CentOS
* RedHat
* Suse
* Fedora

Attributes
==========

* **node[:bind9][:enable_ipv6]**       - Enables BIND to listen on an IPv6 address. Default is: On
* **node[:bind9][:allow_query]**       - Allow clients to query the nameserver. Default is: anyone
* **node[:bind9][:allow_recursion]**   - Allow recursive name resolution. Default is: none (to prevent DNS cache poisoning)
* **node[:bind9][:allow_update]**      - Allow dynamic DNS updates. Default is: none
* **node[:bind9][:allow_transfer]**    - Allow zone transfers globally. Default is: none
* **node[:bind9][:enable_forwarding]** - Enables forwarding of requests. Default is: No forwarding
* **node[:bind9][:forwarders]**        - Array for forwarding DNS. Default is: 4.4.4.4 and 8.8.8.8 (Google DNS)

Usage
=====

Add "recipe[bind9]" directly to a node or a role.
