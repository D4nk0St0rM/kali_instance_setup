#### https://libredns.gr/



This is a DNS service run by LibreOps.

The goal is to offer a public encrypted DNS service that people can use to maintain the secrecy of their DNS traffic, but also circumvent censorship.

We already support DNS over HTTPS and DNS over TLS.
DNS over HTTPS

Endpoint https://doh.libredns.gr/dns-query

  DNS over HTTPS (DoH) is best to be configured and used on applications, namely browsers.

At the moment the only browser that has sufficient support is Firefox. To configure Firefox:

    Open Firefox preferences and navigate to:
    General > Network Settings > Settings
    At the bottom of this dialog:
    Enable DNS over HTTPS
    Change from the default setting to Custom and fill in:
    https://doh.libredns.gr/dns-query

    firefox doh

Blocking Ads and Trackers

  We also offer an endpoint that blocks a crowdsourced list of known advertisement and tracking domains.

    Endpoint https://doh.libredns.gr/ads



##### DNS over TLS

    IP 116.202.176.26
    Port 853
    Domain dot.libredns.gr

  DNS over TLS (DoT) is best to be configured globally for the entire operating system.

A few clients already support the protocol, and the easiest way is to configure systemd to use it:

    Open /etc/systemd/resolved.conf with you favorite editor and sudo rights.
    Make sure you have the following options:
    [Resolve]
    DNS=116.202.176.26
    FallbackDNS=127.0.0.1 ::1
    DNSOverTLS=yes

        If you are on systemd < 243, then use opportunistic instead of yes. 

Blocking Ads and Trackers

  We also offer DoT at a different port that blocks a crowdsourced list of known advertisement and tracking domains.

    IP 116.202.176.26
    Port 854
