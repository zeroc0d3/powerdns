FROM tcely/dnsdist

COPY dnsdist.conf /etc/dnsdist/dnsdist.conf
EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/usr/local/bin/dnsdist", "--uid", "dnsdist", "--gid", "dnsdist"]
CMD ["--disable-syslog"]
