Domain-Search-System Dockerfile
===============================
**Dockerfile** for [trusted build](https://index.docker.io/u/mkroli/dss/) of [DSS].

The DNS frontend listens internally on port **5353**, the HTTP-admin GUI on port **8080**.


Usage
-----
```
docker run -d -p 5380:8080 -p 53:5353/udp -name dss mkroli/dss
```

[DSS]:https://github.com/mkroli/domain-search-system
