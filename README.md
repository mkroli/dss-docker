Domain-Search-System Dockerfile
===============================
**Dockerfile** for [trusted build](https://index.docker.io/u/mkroli/dss/) of [DSS].

The DNS frontend listens internally on port **5353**, the HTTP-admin GUI on port **5380**.


Usage
-----
With default parameters:
```
docker run -d -p 5380:5380 -p 53:5353/udp -name dss mkroli/dss
```

For a list of possible parameters:
```
docker run -rm mkroli/dss --help
```

[DSS]:https://github.com/mkroli/domain-search-system
