#!/bin/sh

nameserver=`grep '^nameserver' /etc/resolv.conf | head -n 1 | cut -d ' ' -f 2`
export JVM_OPT="-Dserver.fallback.address=${nameserver}"
exec /opt/dss/bin/dss
