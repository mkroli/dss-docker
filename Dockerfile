FROM dockerfile/java
MAINTAINER mkroli

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
RUN echo 'deb http://content.wuala.com/contents/mkroli/public/debian/ mkroli/' > /etc/apt/sources.list.d/mkroli.list
RUN curl https://content.wuala.com/contents/mkroli/public/debian/mkroli_public_key.asc | apt-key add -
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade --force-yes -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y dss xinetd supervisor
RUN apt-get clean
RUN mkdir -p /opt/dss/data /opt/dss/log
RUN chown nobody:nogroup /opt/dss/data /opt/dss/log

ADD dss.conf /opt/dss/etc/dss.conf
ADD dss.xinetd /etc/xinetd.d/dss
ADD supervisord.conf /etc/supervisor/conf.d/dss.conf
ADD dss.sh /opt/dss/bin/dss.sh

EXPOSE 5353 8080

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/dss.conf"]
