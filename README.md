Description
===========

This cookbook takes care of the installation and configuration of BIND9. At the moment you're able to define some global variables and to manage your zonefiles via data bags (json example below).
It currently also supports automatic serial number generation and automatic resource records for chef nodes (see optional json in example below)
Besides that there's not much to see, e.g. no DNSSEC, no configurable logging, no rndc shell operations or other safety checks (named-checkconf, etc.).

It's my intention to round its edges over time. If you want to help feel free to contribute!

**DISCLAIMER**:  
Please keep in mind that this cookbook is far from finished and not adequately tested. It could break your setup. Use at **YOUR OWN RISK**!

Requirements
============

Platform:

* Debian
* Ubuntu
* Centos

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

Add "recipe[bind9]" directly to a node or a role. If you want to use BIND9 for serving domains you may add the appropriate data via data bags (example below).
Please note that the data bag's structure is mandatory except:
-TTL for DNS records (if you decide to leave it empty, the global TTL will take over).
-autodomain for the zone (if you include this, automatic records will be added for chef nodes whose "domain" matches this)
  
    $ knife data bag create zones
    $ knife data bag create zones exampleDOTcom
    $ ... do something ...
    $ knife data bag from file zones exampleDOTcom.json



    {
      "id": "exampleDOTcom",
      "domain": "example.com",
      "type": "master",
      "allow_transfer": [ "4.4.4.4",
                          "8.8.8.8" ],
      "zone_info": {
        "global_ttl": 300,
        "soa": "ns.example.com.",
        "contact": "user.example.com.",
				"autodomain": "example.com.",
        "nameserver": [ "ns.example.com",
                        "ns.example.net",
                        "ns2.example.org.",
                        "ns3.example.de." ],
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
          "ip": "127.0.0.1"
        },{
          "name": "img",
          "ttl": 30,
          "type": "A",
          "ip": "127.0.0.1"
        },{
          "name": "mail",
          "type": "CNAME",
          "ip": "ghs.google.com."
        }]
      }
    }
