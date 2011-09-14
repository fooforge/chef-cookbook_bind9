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
      "id": "fooforgeDOTcom",
      "domain": "fooforge.com",
      "type": "master",
      "allow_transfer": [ "4.4.4.4",
                          "8.8.8.8" ],
      "zone_info": {
        "soa": "ns.fooforge.com.",
        "contact": "mike.fooforge.com.",
        "serial": 2011091401,
        "nameserver": [ "ns2.fooforge.com.",
                        "ns3.fooforge.com." ],
        "mail_exchange": [{
            "host": "mx01.fooforge.com.",
            "priority": 90
          },{
            "host": "mx02.fooforge.com.",
            "priority": 80
        }]
      }
    }


