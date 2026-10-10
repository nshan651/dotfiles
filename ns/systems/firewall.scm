(define-module (ns systems firewall)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:export (base-nftables-ruleset))

(define base-nftables-ruleset
  (plain-file "nftables.conf"
   "define trusted_ifs = { \"docker0\", \"br-*\", \"virbr*\", \"tailscale0\" }
table inet host_fw
delete table inet host_fw

table inet host_fw {
  chain input {
    type filter hook input priority filter; policy drop;

    iif lo accept comment \"Accept any localhost traffic\"
    iifname $trusted_ifs accept comment \"Trusted virtual interfaces\"

    ct state invalid drop comment \"Drop invalid connections\"
    fib daddr . iif type != { local, broadcast, multicast } drop comment \"Drop packets if the destination IP address is not configured on the incoming interface (strong host model)\"
    ct state { established, related } accept comment \"Accept traffic originated from us\"

    meta l4proto { icmp, ipv6-icmp } accept comment \"Accept ICMP\"
		ip protocol igmp accept comment \"Accept IGMP\"

    tcp dport 22 ct state new limit rate 15/minute accept comment \"Accept ssh (rate limited)\"
    meta l4proto { tcp, udp } th dport { 80, 443 } accept comment \"Accept HTTP (ports 80, 443)\"

    udp dport mdns ip6 daddr ff02::fb accept comment \"Accept mDNS (v4)\"
		udp dport mdns ip daddr 224.0.0.251 accept comment \"Accept mDNS (v6)\"

		counter comment \"Count any other traffic\"
  }

  chain forward {
    type filter hook forward priority filter; policy accept;

    ct state new ct status != dnat iifname != $trusted_ifs drop comment \"Don't route new connections from external interfaces\"
  }

  chain output {
    type filter hook output priority filter; policy accept;
  }
}
"))

(define base-nftables-service
  (service nftables-service-type
           (nftables-configuration
            (ruleset base-nftables-ruleset))))
