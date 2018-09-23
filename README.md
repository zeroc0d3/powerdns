# powerdns
Docker images of PowerDNS software built on Alpine Linux, with sample configuration
- https://hub.docker.com/r/tcely/dnsdist/
- https://hub.docker.com/r/tcely/powerdns-recursor/
- https://hub.docker.com/r/tcely/powerdns-server/

## Feature Configuration
* Authoritative Server
* Recursive Server
* Authoritative and Recursive Servers

## Examples of using these images
* ### As a base for your own `Dockerfile`
  ```dockerfile
    FROM tcely/dnsdist

    COPY dnsdist.conf /etc/dnsdist/dnsdist.conf
    EXPOSE 53/tcp 53/udp

    ENTRYPOINT ["/usr/local/bin/dnsdist", "--uid", "dnsdist", "--gid", "dnsdist"]
    CMD ["--disable-syslog"]
  ```
* ### In your `docker-compose.yml`
  ```yaml
    version: '3'
    services:
      dnsdist:
        image: 'tcely/dnsdist'
        restart: 'unless-stopped'
        tty: true
        stdin_open: true
        command: ["--disable-syslog", "--uid", "dnsdist", "--gid", "dnsdist", "--verbose"]
        volumes:
          - ./dnsdist.conf:/etc/dnsdist/dnsdist.conf:ro
        expose:
          - '53'
          - '53/udp'
        ports:
          - '53:53'
          - '53:53/udp'
      recursor:
        image: 'tcely/powerdns-recursor'
        restart: 'unless-stopped'
        command: ["--disable-syslog=yes", "--log-timestamp=no", "--local-address=0.0.0.0", "--setuid=pdns-recursor", "--setgid=pdns-recursor"]
        volumes:
          - ./pdns-recursor.conf:/etc/pdns-recursor/recursor.conf:ro
        expose:
          - '53'
          - '53/udp'

  ```

## Running
`docker-compose -f docker-compose.yml up`

## References
* [Ref-1: Dockerhub-PowerDNS](https://github.com/tcely/dockerhub-powerdns)
* [Ref-2: DnsDist-Docker](https://github.com/uniplug/dnsdist-docker)
* [Ref-3: PowerDNS Authoritative Server](https://doc.powerdns.com/authoritative/index.html)
* [Ref-4: PowerDNS Repository](https://github.com/PowerDNS/)
* [Ref-5: Tutorial Configuration](https://joekuan.wordpress.com/2015/06/19/powerdns-configuring-authoritative-server-and-forwarding-queries-to-multiple-authoritative-servers/)
