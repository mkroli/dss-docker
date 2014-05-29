FROM dockerfile/java
MAINTAINER mkroli

RUN echo 'deb http://content.wuala.com/contents/mkroli/public/debian/ mkroli/' > /etc/apt/sources.list.d/mkroli.list && \
    curl https://content.wuala.com/contents/mkroli/public/debian/mkroli_public_key.asc | apt-key add - && \
    apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y python dss && \
    apt-get clean && \
    mkdir -p /opt/dss/data /opt/dss/log && \
    chown nobody:nogroup /opt/dss/data /opt/dss/log

ADD dss.conf.template /opt/dss/etc/
ADD dss.py /

EXPOSE 5353 8080

ENTRYPOINT ["/dss.py"]
