#!/usr/bin/env python

from optparse import OptionParser
from string import Template
from os import execl

def read_file(filename):
  f = open(filename, 'r')
  try:
    return f.read()
  finally:
    f.close()

def write_file(filename, content):
  f = open(filename, 'w')
  try:
    f.write(content)
  finally:
    f.close()

def or_else(var, default): return default if var == None else var

dns_server = next(line.partition(' ')[2] for line in read_file("/etc/resolv.conf").split("\n") if line.startswith("nameserver"))

parser = OptionParser(usage="docker run -p 5380:5380 -p 5354:5353/udp -rm mkroli/dss [options]")
parser.add_option("--server-fallback-address", dest="server_fallback_address", help="the IP of the DNS server used as relay")
parser.add_option("--server-autoindex", dest="server_autoindex", help="automatically add successfully looked up hosts to the index")
parser.add_option("--index-include-host", dest="index_include_host", help="whether to include the hostname in the search index")
parser.add_option("--index-include-domain", dest="index_include_domain", help="whether to include the domainname in the search index")
(opts, args) = parser.parse_args()

options = {
  "server_fallback_address": or_else(opts.server_fallback_address, dns_server),
  "server_autoindex": or_else(opts.server_autoindex, "false"),
  "index_include_host": or_else(opts.index_include_host, "true"),
  "index_include_domain": or_else(opts.index_include_domain, "true")
}
write_file("/opt/dss/etc/dss.conf", Template(read_file("/opt/dss/etc/dss.conf.template")).substitute(options))

execl("/opt/dss/bin/dss", "dss")
