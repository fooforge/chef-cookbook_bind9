Description
===========

Installation and configuration of BIND9.

Please keep in mind: This cookbook is far from finished and could break your setup. Use at your own risk!

Requirements
============

Platform:

* Debian
* Ubuntu

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

Add "recipe[bind9]" directly to a node or a role. If you want to use BIND9 for serving domains you may add the appropriate data via data bags (example below)

{
  "id": "exampleDOTcom",
  "domain": "example.com",
  "type": "master",
  "allow_transfer": [ "4.4.4.4",
                      "8.8.8.8" ],
  "zone_info": {
    "soa": "ns.example.com.com.",
    "contact": "mike.example.com.",
    "serial": 2011091401,
    "nameserver": [ "ns.example.com",
                    "ns.inwx.de",
                    "ns2.inwx.de.",
                    "ns3.inwx.de." ],
    "mail_exchange": [{
      "host": "ASPMX.L.GOOGLE.COM.",
      "priority": 10
    },{
      "host": "ALT1.ASPMX.L.GOOGLE.COM.",
      "priority": 20
    },{
      "host": "ALT2.ASPMX.L.GOOGLE.COM.",
      "priority": 20
    },{
      "host": "ASPMX2.GOOGLEMAIL.COM.",
      "priority": 30
    },{
      "host": "ASPMX3.GOOGLEMAIL.COM.",
      "priority": 30
    },{
      "host": "ASPMX4.GOOGLEMAIL.COM.",
      "priority": 30
    },{
      "host": "ASPMX5.GOOGLEMAIL.COM.",
      "priority": 30
    }],
    "records": [{
      "name": "www",
      "type": "A",
      "ip": "176.9.28.55"
    },{
      "name": "img",
      "type": "A",
      "ip": "176.9.28.55"
    },{
      "name": "mail",
      "type": "CNAME",
      "ip": "ghs.google.com."
    }]
  }
}
